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
        end
    end

    def not_authorization
        redirect_to current_user, alert: "**Not Authorized to View this page"
    end
end
