class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  mount_uploader :avatar, AvatarUploader

  has_many :user_connections, foreign_key: "followee_id", dependent: :destroy
  has_many(:reverse_user_connections, class_name: :UserConnection,
        foreign_key: "follower_id", dependent: :destroy)
  has_many :followers, -> { where('user_connections.dismiss = ?', false) }, class_name: :User, through: :user_connections, source: "follower"

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
