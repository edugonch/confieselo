class Rating
  include Mongoid::Document
  field :score, type: Integer, default: 0
  belongs_to :confesion
  belongs_to :user
end
