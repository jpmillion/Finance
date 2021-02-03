class AdminsController < ApplicationController

    skip_before_action :login_required, only: :create

    def create
        @user = User.new(admin_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to current_user, alert: "Successful Sign Up"
        else
            render :'users/new'
        end
    end

    def show
        
    end

    def edit
        render :'users/edit'
    end

    def update
        if current_user.update(admin_params)  
            redirect_to current_user, alert: "Profile Updated"
        else
            render :'users/edit'
        end
    end

    def destroy
        
    end

    private

    def admin_params
        params.require(:admin).permit(:first_name, :last_name, :username, :email, :admin, :password, :password_confirmation, :type)
    end
end
