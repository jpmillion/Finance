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
        # elsif params[:id]
        #     if params[:id].to_i != session[:user_id]
        #         redirect_to user_path(session[:user_id]), alert: "Access Denied"
        #     end
        # elsif params[:user_id]
        #     if params[:user_id].to_i != session[:user_id]
        #         redirect_to user_path(session[:user_id]), alert: "Access Denied"
        #     end
        # elsif params[:user_account_id]
        #     if !current_user.user_accounts.include?
        #         redirect_to user_path(session[:user_id]), alert: "Access Denied"
        #     end  
        end
    end

    def stock_quote(symbol, shares)
        stock = IEX::Api::Client.new(
            publishable_token: 'pk_02f29690e23d4897b4b7916f6e78d39e',
            secret_token: 'sk_a74468b214424b4c825232000f18608c',
            endpoint: 'https://cloud.iexapis.com/v1'
        ).quote(symbol)
        { symbol: stock['symbol'], name: stock['company_name'], value: (stock['latest_price']*shares.to_f).round(2), shares: shares }
    end
end
