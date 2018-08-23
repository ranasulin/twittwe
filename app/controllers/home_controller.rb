class HomeController < ApplicationController
  def show
    p current_user
    @followers = current_user.followers
  end
end
