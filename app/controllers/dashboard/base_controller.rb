class Dashboard::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  private
  def authenticate_admin
    unless current_user.admin?
      redirect_to root_path, notice: "Not Allowed!"
    end
  end
end