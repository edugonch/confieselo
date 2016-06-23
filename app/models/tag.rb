class Tag
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  has_and_belongs_to_many :confesions
  field :name, type: String

  search_in :name

  def to_param
    name
  end

  def to_s
    name
  end
end
