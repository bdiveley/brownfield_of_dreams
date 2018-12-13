class InviteController < ApplicationController
  def new
  end

  def create
    service = GitHubService.new({token: current_user.token, handle: params[:handle] })
    response = service.find_email
    if response[:email]
      UserNotifierMailer.invite(current_user, response).deliver_now
      flash[:notice] = "Successfully sent invite!"
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end
      redirect_to dashboard_path
  end
end
