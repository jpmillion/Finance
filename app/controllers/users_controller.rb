class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user), alert: "Successfull Registration"
        else
            render :new
        end
    end

    def destroy
        User.find_by(id: params[:id]).destroy
        redirect_to root_path, alert: "Account Successfully Terminated"
    end

    def show
        @user = User.find_by(id: params[:id])
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :email, :admin, :password, :password_confirmation)
    end
end
