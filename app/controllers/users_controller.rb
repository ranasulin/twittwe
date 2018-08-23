class UsersController < ApplicationController
  respond_to :html, :js
  def show
  end

  def add_follower
    User.find(params[:user_id]).followers << current_user

    respond_with(@comment) do |format|
      format.html { redirect_to :back }
    end
  end
end
