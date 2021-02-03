class CustomersController < ApplicationController

    skip_before_action :login_required, only: :create

    def create
        @user = User.new(customer_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to current_user, alert: "Successful Sign Up"
        else
            render "users/new"
        end
    end

    def show
    end

    def edit
        
    end

    def update
        
    end

    def destroy
        
    end

    private

    def customer_params
        params.require(:customer).permit(:first_name, :last_name, :username, :email, :admin, :password, :password_confirmation, :type)
    end
end
