class UsersController < ApplicationController
  before_action only: [:edit]
  respond_to :html, :js

  def show
    get_followers
  end

  def follow
    @user = User.find(params[:user_id])
    createFollower = UserConnection.create(follower: current_user, followee: @user)
    if @user.save
      dismiss(@user, current_user)
    else
      flash[:error] = "Cannot follow #{@user.name}"
    end
  end

  def unfollow
    @user = User.find(params[:user_id])
    dismiss(@user, current_user)
  end

  def mention_user
    @user = User.find(params[:user_id])
    if @user.mentions << current_user
      dismiss(@user, current_user)
    else
      flash[:error] = "Cannot mention #{@user.name}"
    end
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information updated"
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Invalid user information"
      redirect_to edit_user_registration_path
    end
  end

  private

  def dismiss (follower, followee)
    relation = UserConnection.where("follower_id = ? AND followee_id = ?", @user.id, current_user.id)
    if relation.update_all(dismiss:true)
      update_view
    else
      flash[:error] = "Could not complete action"
    end
  end

  def get_followers
    @followers = current_user.followers.limit(3)
  end

  def update_view
    get_followers

    respond_with(@followers) do |format|
      format.html { redirect_to :back }
      format.js { render action: 'update_follower.js.erb'}
    end
  end

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
