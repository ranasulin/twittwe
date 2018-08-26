class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  mount_uploader :avatar, AvatarUploader

  has_and_belongs_to_many :followers,
  class_name: "User",
  join_table: "user_connections",
  foreign_key: "follower_id",
  association_foreign_key: "followee_id"

  has_and_belongs_to_many :mentions,
  class_name: "User",
  join_table: "table_mentions",
  foreign_key: "mention_subject",
  association_foreign_key: "mentioned_by"

  def follows?(user)
    user.followers.where(id: id).first
  end

  def mentioned?(user)
    mentions.where(id: user.id)
  end

  def influencer?
    followers.count >= 3
  end

  def user_params
   params.require(:user).permit(:name, :avatar)
end
end
