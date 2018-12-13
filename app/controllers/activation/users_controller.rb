class Activation::UsersController < ApplicationController

  def update
    user = User.find_by(email: params[:email])
    if params[:activation] == user.activation_digest
      user.update(status: activation_params)
      flash[:notice] ="Thank you! Your account is now activated."
      redirect_to login_path
    else
      four_oh_four
    end
  end

private

  def activation_params
    params.permit(:status)
  end

end
