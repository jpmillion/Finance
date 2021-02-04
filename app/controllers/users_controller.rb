class UsersController < ApplicationController

    skip_before_action :login_required, only: [:new, :create]
    # before_action :check_authorization, except: [:new, :create, :financial_stats]
    # before_action :check_admin_authorization, only: :financial_stats

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to current_user, alert: "Successful Sign Up"
        else
            @user.type = nil
            render :new
        end
    end

    # def financial_stats
        
    # end

    # def show
        
    # end

    # def edit 
    # end

    # def update
    #     if current_user.update(user_params)  
    #         redirect_to current_user, alert: "Profile Updated"
    #     else
    #         render :edit
    #     end
    # end

    # def destroy
    #     current_user.destroy
    #     session.delete :user_id
    #     redirect_to root_path, alert: "Account Successfully Terminated"
    # end

    # private

    # def check_authorization 
    #     not_authorization unless current_user.id == params[:id].to_i 
    # end

    # def check_admin_authorization
    #     not_authorization unless current_user.type == 'Admin'
    # end

    def user_params
        # if params[:customer]
        #     params.require(:customer).permit(:first_name, :last_name, :username, :email, :admin, :password, :password_confirmation, :type)

        # elsif params[:admin]
        #     params.require(:admin).permit(:first_name, :last_name, :username, :email, :admin, :password, :password_confirmation, :type)

        #else
            params.require(:user).permit(:first_name, :last_name, :username, :email, :admin, :password, :password_confirmation, :type)
        #end
    end
end
