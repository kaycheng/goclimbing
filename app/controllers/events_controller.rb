class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_event, except: [:new, :create, :draft, :public]
  before_action :count_events, only: [:draft, :public]

  
  def new
    @event = current_user.events.new
  end

  def create
    @event = current_user.events.new(event_params)
    @event.publish! if params[:publish]

    if @event.save
      if params[:publish]
        redirect_to user_page_path(current_user.username), notice: "已建立新團"
      else
        redirect_to edit_event_path(@event), notice: "已儲存"
      end
    else
      render new_event_path, notice: "請重新建立"
    end
  end

  def edit
    unless current_user == @event.user
      redirect_to root_path, notice: "你沒有權限更改！"
    end
  end
  
  def update
    if @event.update(event_params)
      case
      when params[:publish]
        @event.publish!
        redirect_to user_page_path(current_user.username), notice: "已發布"
      when params[:unpublish]
        @event.unpublish!
        redirect_to user_page_path(current_user.username), notice: "已下架"
      else
        redirect_to user_page_path(current_user.username), notice: "已儲存"
      end
    else
      render edit_event_path(@event), notice: "請重新編輯"
    end
  end

  def show
    @comment = @event.comments.new
  end

  def destroy
    if @event.destroy
      redirect_to user_page_path(current_user.username), notice: "已刪除"
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
    @draft_events = Event.where(status: "draft", user: current_user)
  end

  def public 
    @public_events = Event.where(status: "published", user: current_user)
  end


  private

  def event_params
    params.require(:event).permit(:title, :content, :note, :date, :location, :gather_location)
  end

  def find_event
    @event = Event.find(params[:id])
  end

  def count_events
    @draft_count = Event.where(status: "draft", user: current_user).count
    @public_count = Event.where(status: "published", user: current_user).count
  end
end