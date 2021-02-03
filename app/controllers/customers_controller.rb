class CustomersController < ApplicationController

    def create
        @customer = User.new(customer_params)
        if @customer.save
            session[:user_id] = @customer.id
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
