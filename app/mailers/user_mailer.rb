class UserMailer < ApplicationMailer

  default :from => "hello@theygotfit.com"

  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "TheyGotFit Account Confirmation")
  end

  def password_reset(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "TheyGotFit Password Reset")
  end

  def new_comment(user, comment)
    @user = user
    @comment = comment
    mail(:to => "Max <flufci@gmail.com>", :subject => "#{user.name} just left a comment!")
  end

end
