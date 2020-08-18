class WelcomeController < ApplicationController
  layout "search", only: :index
  before_action :find_user, except: :index

  def index
    if params[:search]
      @events = Event.published.not_overdue.where('title LIKE ? OR location LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%").includes(:user)
    else
      @newest_events = Event.published.not_overdue.order(created_at: :desc).includes(:user).limit(20)
      @papular_events = Event.published.not_overdue.order(participates_count: :desc).includes(:user).limit(5)
    end
  end
  
  def user
    @events = @user.events.published.not_overdue.order(date: :desc).includes(:user)
    @participated_events = @user.participated_events.published.not_overdue.order(date: :desc).includes(:user)
    @overdue_participated_events = @user.participated_events.published.overdue.order(date: :desc).includes(:user)
  end

  def followers
    @followers = @user.followers
  end

  def followings
    @followings = @user.followings
  end

  private
  def find_user
    @user = User.find_by(username: params[:username])
  end
end