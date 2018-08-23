class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit]
  respond_to :html, :js

  def show
  end

  def add_follower
    @user = User.find(params[:user_id])
    @user.followers << current_user

    respond_with(@user) do |format|
      format.html { redirect_to :back }
    end
  end

  def remove_follower
    @user = User.find(params[:user_id])
    followerObject = @user.followers.find(current_user.id)
    @user.followers.delete(followerObject)

    respond_with(@user) do |format|
      format.html { redirect_to :back }
      format.js { render action: 'add_follower.js.erb'}
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

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
