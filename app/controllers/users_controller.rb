class UsersController < ApplicationController 
    def signin
        user = User.find_by(email: user_params[:email])
        if user && user.authenticate(user_params[:password])
            render json: user, except: [:created_at, :updated_at]
        end 
    end

    private
    
    def user_params 
        params.require(:user).permit(:username, :password, :email)
    end 
end