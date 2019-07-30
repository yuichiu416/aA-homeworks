class SessionsController < ApplicationController
    def new
        render :new
    end
    
    def create
        user = User.find_by_credentials(params[:user_name], params[:password])
        if user
            session[:session_token] = user.session_token
            flash[:success] = "Logged in successfully."
            redirect_to cats_url
        else

            <ActionController::Parameters {"params"=>{":user_name"=>"123", ":password"=>"123123"}, "controller"=>"sessions", "action"=>"create"} permitted: false>
            
            flash[:error] = "Wrong email/password combo"
            fail
            return render plain: "failed"
            render :new, status: 401
        end
    end

    def destroy
        current_user.reset_session_token!
        session[:session_token] = nil
        flash[:success] = "Logged out successfully"
        redirect_to cats_url
    end
end