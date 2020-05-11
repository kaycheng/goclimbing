class WelcomeController < ApplicationController

  def index
    @events = Event.published.order(updated_at: :desc).includes(:user)
  end
  
  def user
    @user = User.find_by(username: params[:username])
    @events = @user.events.published.order(updated_at: :desc).includes(:user)
  end

end