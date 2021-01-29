class PositionsController < ApplicationController
    def new
        @equity = Equity.new(user_account_id: params[:user_account_id])
        @user_account = @equity.user_account
    end

    def create
        symbol, shares = params[:equity][:symbol].upcase, params[:equity][:shares].to_i
        @user_account = UserAccount.find_by(id: params[:user_account_id])
        if @user_account.positions.exists?(symbol: symbol)
            redirect_to new_user_account_equity_path(@user_account), alert: "You already have a position in #{symbol}"
        else
            @equity = @user_account.positions.build(equity_params)
            if @equity.save
                if @equity.affordable?(symbol, shares)
                    redirect_to equity_path(@equity), alert: "You purchased #{shares} share(s) of #{symbol} for #{@equity.total_purchase_price(symbol, shares)}"
                else
                    @equity.destroy
                    redirect_to new_user_account_equity_path(@user_account), alert: "Insufficient Funds"
                end
            else
                render :new
            end    
        end
    end

    def show
        @position = Position.find_by(id: params[:id])
    end

    def edit
        #binding.pry
        @position = Position.find_by(id: params[:id])
        redirect_to customer_path(current_user), alert: "Position does not exist" if @position.nil?
    end

    def update
        @position = Position.find_by(id: params[:id])
        redirect_to customer_path(current_user) if @position.nil?
        params[:cash] ? field = params[:cash][:value].to_f : field = params[:equity][:shares].to_i
        flash[:alert] = @position.transaction(params[:transaction], field)
        @position.save
        redirect_to user_account_path(@position.user_account)
    end

    private

    def position_params
        params.require(:position).permit(:symbol, :shares, :user_account_id, :type, :value)
    end

    def equity_params
        params.require(:equity).permit(:symbol, :shares, :type)
    end
end
