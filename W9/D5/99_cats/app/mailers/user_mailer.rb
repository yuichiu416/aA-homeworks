class UserMailer < ApplicationMailer
    default from: 'yuichiu416@gmail.com'
    def welcome_email(user)
        @user = user
        @url  = 'http://example.com/login'
        mail(to: 'yuichiu416@gmail.com', subject: 'Welcome to My Awesome Site')
  end
end
