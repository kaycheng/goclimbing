class WelcomeController < ApplicationController

  def index
    @events = Event.published.not_overdue.order(date: :desc).includes(:user)
  end
  
  def user
    @user = User.find_by(username: params[:username])
    @events = @user.events.published.not_overdue.order(date: :desc).includes(:user)
    @participated_events = @user.participated_events.published.not_overdue.order(date: :desc).includes(:user)
    @overdue_participated_events = @user.participated_events.published.overdue.order(date: :desc).includes(:user)
  end

end