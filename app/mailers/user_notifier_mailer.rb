class UserNotifierMailer < ApplicationMailer

  def inform(user)
    @user = user
    mail(to: user.email, subject: "Activation Email")
  end
end
