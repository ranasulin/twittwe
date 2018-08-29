class UserConnection < ActiveRecord::Base
  belongs_to :follower, :class_name => :User
  belongs_to :followee, :class_name => :User

  scope :not_dismissed, -> { where(dismiss: false) }
end
