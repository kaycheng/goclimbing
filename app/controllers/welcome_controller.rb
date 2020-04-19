class WelcomeController < ApplicationController

  def index
  end
  
  def user
    @user = User.find_by(username: params[:username])
  end

end