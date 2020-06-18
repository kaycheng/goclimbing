class Dashboard::UsersController < Dashboard::BaseController
  def index
    @users = User.order(created_at: :desc)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to dashboard_users_path, notice: "User already deleted."
  end
end