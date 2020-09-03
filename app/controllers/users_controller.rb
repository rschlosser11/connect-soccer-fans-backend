class UsersController < ApplicationController 
    def signin
        user = User.find_by(email: user_params[:email])
        if user && user.authenticate(user_params[:password])
            render json: user, except: [:created_at, :updated_at, :password]
        end 
    end

    def create
        user = User.find_by(email: user_params[:email])
        if user
            render json: user, except: [:created_at, :updated_at, :password]
        else
            new_user = User.new(user_params)
            if new_user.save
                render json: new_user, except: [:created_at, :updated_at, :password]
            end
        end
    end

    private
    
    def user_params 
        params.require(:user).permit(:username, :password, :email)
    end 
end