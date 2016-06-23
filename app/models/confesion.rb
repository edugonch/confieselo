class Confesion < Commentable
  include Mongoid::Timestamps
  include Mongoid::Search
  has_and_belongs_to_many :tags, index: true, autosave: true
  belongs_to :user
  has_many :ratings
  
  embeds_many :comments
  accepts_nested_attributes_for :comments, :allow_destroy => true
  attr_accessor :tag_list, :score
  index 'comments' => 1
  validates :tittle, presence: true, length: { minimum: 10, maximum: 100 }
  validates :message, presence: true, length: { minimum: 100 }
  validates :user, presence: true
  validates :slug, uniqueness: true, presence: true
  before_validation :generate_slug
  before_save :prepare_confesion


  field :tittle, type: String
  field :message, type: String
  field :anonymous, type: Mongoid::Boolean, default: true
  field :slug,    :type => String
  field :image, type: String

  search_in :tittle, :message, :tags => :name

  def create_comment!(params, anon = true, parent_id = nil)
    if parent_id
      parent = comments.find(parent_id)
      if parent
        comment = parent.child_comments.new(params)
      end
    else
      comment = comments.new(params)
    end

    if anon
      comment.author = "Anonimo"
    else
      comment.author = self.user.username
    end
    comment.save!
    comment
  end

  def comments_list(sort=:asc)
    if Comment.respond_to?(sort)
      comments.send(sort,:path)
    else
      raise ArgumentError, "Wrong argument!"
    end
  end

  def branch_for(comment_id)
    comments.select{|i| i.path =~ Regexp.new('^' + comments.find(comment_id).path)}
  end

  def average_rating
    puts "ratings.sum(:score) ==> #{ratings.sum(:score)}"
   
    puts "ratings ==> #{ratings.to_json}"
    scores_size = ratings.where(:score.gt => 0).size
    if scores_size <= 0
      scores_size
    else
      ratings.sum(:score) / ratings.where(:score.gt => 0).size
    end
  end

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= "#{tittle.gsub(/['`]/, '').parameterize}-#{message.length}"
  end

  def self.tagged_with(name)
    Tag.find_by!(name: name).confesions
  end

  def self.tag_counts
    self.tags.count
  end

  def tag_list=value
    value.split(',').each do |tag|
      self.tags.build(:name => tag).save
    end
  end

  def tag_list
    self.tags.join(',')
  end

  def post_to_facebook
    user_graph = Koala::Facebook::API.new(Rails.configuration.facebook.access_token)
    page_token = user_graph.get_page_access_token(Rails.configuration.facebook.pageid)
    page_graph = Koala::Facebook::API.new(page_token)
    page_graph.put_wall_post(self.tittle, 
	{"link" => Rails.application.routes.url_helpers.confesion_url(self, :host => Rails.configuration.host.name)})
  end

  private

  def prepare_confesion
    # Replace Email
    mail_length = /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/.match(self.message).to_s.length
    self.message.gsub!(/[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/, 'X' * mail_length)
    # Replace Phone Number
    phone_length = /([0-9\s\-]{7,})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?/.match(self.message).to_s.length
    self.message.gsub!(/[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/, 'X' * phone_length)
  end

end
