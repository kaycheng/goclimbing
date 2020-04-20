class EventsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :find_event, only: [:edit, :show, :update, :destory] 

  def index
    @events = current_user.events.order(updated_at: :desc)
  end

  def new
    @event = current_user.events.new
  end

  def create
    @event = current_user.events.new(event_params)
    if @event.save
      redirect_to events_path, notice: "已建立新團"
    else
      render new_event_path, notice: "請重新建立"
    end
  end
  
  def update
    if @event.update(event_params)
      redirect_to event_path(@event), notice: "已更新"
    else
      render edit_event_path(@event), notice: "請重新編輯"
    end
  end

  def destroy
    if @event.delete
      redirect_to events_path, notice: "已刪除"
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :content, :note, :date, :location, :gather_location)
  end

  def find_event
    @event = current_user.event.find(params[:id])
  end
end