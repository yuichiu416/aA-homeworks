class UsersController < ApplicationController
    protect_from_forgery with: :null_session
    def index
        return render json: params
        if params[:name]
            users = User.where("username = #{params[:user][:name]}")
        else
            users = User.all
        end  
        render json: users
    end

    def create
        user = User.new(user_params)
        if user.save
            render json: user
        else
            render json: user.errors.full_messages, status: 404
        end
    end

    def destroy
        user = User.find(params[:id])
        user.destroy
        render json: user
    end

    private
    def user_params
        params.require(:user).permit(:username)
    end
end