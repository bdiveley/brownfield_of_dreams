class UserNotifierMailer < ApplicationMailer

  def inform(user)
    @user = user
    mail(to: user.email, subject: "Activation Email")
  end

  def invite(user, invited)
    @user = user
    @invited = invited
    mail(to: invited[:email] , subject: "Join Me")
  end
end
