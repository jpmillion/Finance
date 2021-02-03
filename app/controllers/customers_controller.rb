class CustomersController < ApplicationController

    def create
        
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
