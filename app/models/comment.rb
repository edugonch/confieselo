class Comment 
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic
  #attr_accessible :text, :author
  validates :text, presence: true, length: { minimum: 10, maximum: 1000 }
  field :text, :type => String
  field :author, :type => String
  #embedded_in :commentable, polymorphic: true
  #accepts_nested_attributes_for :comments
  recursively_embeds_many
  before_save :prepare_text
   def level
      path.count('.')
    end

    def remove
      self.update_attribute(:deleted_at, Time.now)
    end

    def restore
      self.update_attribute(:deleted_at, nil)
    end

    def deleted?
      !!self.deleted_at
    end

  private

  def prepare_text
    # Replace Email
    mail_length = /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/.match(self.text).to_s.length
    self.text.gsub!(/[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/, 'X' * mail_length)
    # Replace Phone Number
    phone_length = /([0-9\s\-]{7,})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?/.match(self.text).to_s.length
    self.text.gsub!(/[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/, 'X' * phone_length)
  end
end
