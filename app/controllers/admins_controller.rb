class AdminsController < ApplicationController

    skip_before_action :login_required, only: :create
    before_action :check_admin_authorization, except: :create

    def create
        @user = User.new(admin_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to current_user, notice: "Successful Sign Up"
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
            redirect_to current_user, notice: "Profile Updated"
        else
            render :'users/edit'
        end
    end

    def destroy
        current_user.destroy
        session.delete :user_id
        redirect_to root_path, notice: "Account Successfully Terminated" 
    end

    private

    def check_admin_authorization
        if params[:id]
            not_authorization unless current_user.id == params[:id].to_i
        end
        not_authorization unless current_user.type == 'Admin'
    end

    def admin_params
        params.require(:admin).permit(:first_name, :last_name, :username, :email, :admin, :password, :password_confirmation, :type)
    end
end
