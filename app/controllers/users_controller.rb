class UsersController < ApplicationController

    skip_before_action :login_required, only: [:new, :create]

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to customer_path(@user), alert: "Successful Registration"
        else
            render :new
        end
    end

    def show
        @user = current_user
    end

    def edit
        
    end

    def update
        if current_user.update(user_params)
            if params[:customer]
                redirect_to customer_path(current_user), alert: "Successfully Updated Profile"
            else
                redirect_to admin_path(current_user), alert: "Successfully Updated Profile"
            end
        else
            render :edit
        end
    end

    def destroy
        session.delete :user_id
        User.find_by(id: params[:id]).destroy
        redirect_to root_path, alert: "Account Successfully Terminated"
    end

    private

    def user_params
        if params[:customer]
            params.require(:customer)

        elsif params[:admin]
            params.require(:admin)
            
        else
            params.require(:user)
        end
        params.permit(:first_name, :last_name, :username, :email, :admin, :password, :password_confirmation, :type)
    end
end
