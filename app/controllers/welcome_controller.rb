class WelcomeController < ApplicationController

  def index
    @events = Event.published.overdue.order(date: :desc).includes(:user)
  end
  
  def user
    @user = User.find_by(username: params[:username])
    @events = @user.events.published.order(date: :desc).includes(:user)
  end

end