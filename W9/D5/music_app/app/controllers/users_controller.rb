class UsersController < ApplicationController
  def show
    render :show
  end

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'successfully created your account'
      redirect_to new_session_url
    else
      flash.new[:errors] = @user.errors.full_messages
      render :new
    end  
  end

  def activate
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
