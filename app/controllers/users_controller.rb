class UsersController < ApplicationController
  before_action only: [:edit]
  respond_to :html, :js

  def show
    get_followers
  end

  def follow
    @user = User.find(params[:user_id])
    if @user.followers << current_user
      remove_follower_from_db
    else
      flash[:error] = "Cannot follow #{@user.name}"
    end
  end

  def unfollow
    remove_follower_from_db
  end

  def mention_user
    @user = User.find(params[:user_id])
    if @user.mentions << current_user
      remove_follower_from_db
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

  def get_followers
    @followers = current_user.followers.limit(3)
  end

  def remove_follower_from_db
    @user = User.find(params[:user_id])
    followerObject = current_user.followers.find(params[:user_id])
    if !current_user.followers.delete(followerObject)
      flash[:error] = "Cannot remove #{@user.name} from list"
    end

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
