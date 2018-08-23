class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_and_belongs_to_many :followers,
  class_name: "User",
  join_table: "user_connections",
  foreign_key: "follower_id",
  association_foreign_key: "followee_id"

  has_and_belongs_to_many :mentioned_by,
  class_name: "User",
  join_table: "table_mentions",
  foreign_key: "mention_subject",
  association_foreign_key: "mentioned_by"

  def follows?(user)
    p "follows?"
    p user.followers.where(id: id).first
    user.followers.where(id: id).first
  end
end
