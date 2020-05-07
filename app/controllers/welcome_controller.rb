class WelcomeController < ApplicationController

  def index
  end
  
  def user
    @user = User.find_by(username: params[:username])
    @events = @user.events.order(updated_at: :desc)
  end

end