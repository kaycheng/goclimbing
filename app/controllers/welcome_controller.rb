class WelcomeController < ApplicationController

  def index
    @events = Event.order(updated_at: :desc).includes(:user)
  end
  
  def user
    @user = User.find_by(username: params[:username])
    @events = @user.events.order(updated_at: :desc)
  end

end