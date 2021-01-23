class UsersController < ApplicationController

    skip_before_action :login_required, only: [:new, :create]

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user), alert: "Successfull Registration"
        else
            render action: 'new'
        end
    end

    def show
        @user = current_user
    end

    def edit
        @user = current_user
    end

    def update
        
    end

    def destroy
        session.delete :user_id
        User.find_by(id: params[:id]).destroy
        redirect_to root_path, alert: "Account Successfully Terminated"
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :email, :admin, :password, :password_confirmation)
    end
end
