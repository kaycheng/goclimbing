class Dashboard::EventsController < Dashboard::BaseController
  def index
    @events = Event.published.order(created_at: :desc)
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to dashboard_events_path, notice: "Event already deleted."
  end
end