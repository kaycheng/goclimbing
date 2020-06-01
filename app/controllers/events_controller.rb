class EventsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :find_event, except: [:index, :new, :create, :draft, :public]
  before_action :count_events, only: [:draft, :public]

  def index
    if params[:search]
      @events = Event.published.not_overdue.where('title LIKE ? OR location LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%").includes(:user)
    else
      @events = Event.published.not_overdue.order(created_at: :desc).includes(:user).page(params[:page]).per(15)
    end
  end

  def new
    @event = current_user.events.new
  end

  def create
    @event = current_user.events.new(event_params)
    @event.publish! if params[:publish]

    if @event.save
      if params[:publish]
        redirect_to public_events_path, notice: "Created new events."
      else
        redirect_to draft_events_path, notice: "Saved the events."
      end
    else
      render new_event_path, notice: "Please create again."
    end
  end

  def edit
    unless current_user == @event.user
      redirect_to root_path, notice: "You don't allow do it！"
    end
  end
  
  def update
    if @event.update(event_params)
      case
      when params[:publish]
        @event.publish!
        redirect_to public_events_path, notice: "Publish."
      when params[:unpublish]
        @event.unpublish!
        redirect_to draft_events_path, notice: "Unpublish."
      else
        redirect_to draft_events_path, notice: "Saved the event."
      end
    else
      render edit_event_path(@event), notice: "Please edit again."
    end
  end

  def show
    @comment = @event.comments.new
    @comments = @event.comments.order(created_at: :desc).includes(:user)
  end

  def destroy
    if @event.destroy
      redirect_back(fallback_location: root_path)
    end
  end

  def participated
    @event.participates.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unparticipated
    participated = Participate.where(event: @event, user: current_user)
    participated.destroy_all
    redirect_back(fallback_location: root_path)
  end

  def draft
    @draft_events = Event.where(status: "draft", user: current_user).order(created_at: :desc)
  end

  def public 
    @public_events = Event.where(status: "published", user: current_user).order(created_at: :desc)
  end


  private

  def event_params
    params.require(:event).permit(:title, :content, :note, :date, :location, :gather_location, images: [])
  end

  def find_event
    @event = Event.find(params[:id])
  end

  def count_events
    @draft_count = Event.where(status: "draft", user: current_user).count
    @public_count = Event.where(status: "published", user: current_user).count
  end
end