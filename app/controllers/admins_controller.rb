class AdminsController < ApplicationController

    def create
        @adim = User.new(admin_params)
        if @admin.save
            session[:user_id] = @admin.id
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

    def admin_params
        params.require(:admin).permit(:first_name, :last_name, :username, :email, :admin, :password, :password_confirmation, :type)
    end
end
