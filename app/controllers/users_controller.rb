class UsersController < ApplicationController

    skip_before_action :login_required, only: [:new, :create]

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to current_user, notice: "Successful Sign Up"
        else
            @user.type = nil
            render :new
        end
    end

    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :email, :admin, :password, :password_confirmation, :type)
    end
end
