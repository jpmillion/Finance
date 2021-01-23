class ApplicationController < ActionController::Base
    before_action :login_required
    helper_method :current_user
    
    private

    def current_user
        @current_user ||= User.find(session[:user_id])
    end

    def logged_in?
        !!session[:user_id]
    end

    def login_required
        if !logged_in?
            redirect_to login_path, alert: "**Login Required!!"
        elsif params[:id].to_i != session[:user_id]
            redirect_to user_path(session[:user_id]), alert: "Access Denied"
        end
    end
end
