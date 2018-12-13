class Activation::UsersController < ApplicationController

  def update
    user = User.find(params[:id])
    user.update(status: activation_params)
    flash[:notice] ="Thank you! Your account is now activated."
    redirect_to login_path
  end

private

  def activation_params
    params.permit(:status)
  end

end
