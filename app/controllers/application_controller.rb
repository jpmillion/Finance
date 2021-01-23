class ApplicationController < ActionController::Base
    before_action :login_required

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
end
