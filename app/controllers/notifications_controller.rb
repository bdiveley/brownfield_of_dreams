class NotificationsController < ApplicationController

  def create
    UserNotifierMailer.inform(current_user).deliver_now
    flash[:notice] = "Logged in as #{current_user.first_name} #{current_user.last_name}"
    flash[:error] = "This account has not yet been activated. Please check your email."
    session[:user_id] = nil
    redirect_to login_path
  end

end
