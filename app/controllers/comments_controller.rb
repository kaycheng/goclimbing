class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_event, only: :create

  def create
    @comment = @event.comments.new(comment_params)
    @comment.user = current_user

    unless @comment.save
      render js: "alert('Error')"
    end
  end

  private
  def find_event
    @event = Event.find(params[:event_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end