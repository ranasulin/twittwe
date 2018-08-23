class UsersController < ApplicationController
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
end
