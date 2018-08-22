class HomeController < ApplicationController
  def show
    @followers = current_user.followers
  end
end
