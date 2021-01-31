class UsersController < ApplicationController

    skip_before_action :login_required, only: [:new, :create]

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:alert] = "Successful Registration"
            redirect_to customer_path(@user) if @user.type == 'Customer'
            redirect_to admin_path(@user) if @user.type == 'Admin'
        else
            @user.type = nil
            render :new
        end
    end

    def financial_stats
        
    end

    def show
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
        current_user.destroy
        session.delete :user_id
        redirect_to root_path, alert: "Account Successfully Terminated"
    end

    private

    def user_params
        if params[:customer]
            params.require(:customer).permit(:first_name, :last_name, :username, :email, :admin, :password, :password_confirmation, :type)

        elsif params[:admin]
            params.require(:admin).permit(:first_name, :last_name, :username, :email, :admin, :password, :password_confirmation, :type)

        else
            params.require(:user).permit(:first_name, :last_name, :username, :email, :admin, :password, :password_confirmation, :type)
        end
    end
end
