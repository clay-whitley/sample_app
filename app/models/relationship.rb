class Relationship < ActiveRecord::Base
  attr_accessible :followed_id

  belongs_to :follower, class_name: "User" # establishes follower_id as the foreign key
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
