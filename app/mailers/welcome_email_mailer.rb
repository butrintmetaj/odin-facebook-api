class WelcomeEmailMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to our Awesome Site')
  end
end
