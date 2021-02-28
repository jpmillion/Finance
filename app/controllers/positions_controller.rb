class PositionsController < ApplicationController

    before_action :check_customer_user_account, only: [:index, :new, :create]
    before_action :check_customer_positions, except: [:index, :new, :create]

    def index
        @user_account = UserAccount.find_by(id: params[:user_account_id])
        @positions = Position.index_by_user_account(@user_account)
    end

    def new
        @equity = Equity.new(user_account_id: params[:user_account_id])
        @user_account = @equity.user_account
    end

    def create
        symbol, shares = params[:equity][:symbol].upcase, params[:equity][:shares].to_i
        @user_account = UserAccount.find_by(id: params[:user_account_id])
        create_position_or_redirect_if_purchase_not_valid(symbol, shares)   
    end

    def show
        @position = Position.find_by(id: params[:id])
    end

    def edit
        @position = Position.find_by(id: params[:id])
        redirect_to customer_path(current_user), alert: "Position does not exist" if @position.nil?
    end

    def update
        @position = Position.find_by(id: params[:id])
        redirect_to customer_path(current_user) if @position.nil?
        params[:cash] ? cash_amount = params[:cash][:value].to_f : shares = params[:equity][:shares].to_i
        flash[:notice] = @position.transaction(transaction: params[:transaction], cash_amount: cash_amount, shares: shares)
        @position.save if params[:cash]
        redirect_to @position
    end

    def destroy
        @equity = Equity.find_by(id: params[:id])
        user_account = @equity.cash_from_sell
        @equity.destroy
        redirect_to user_account, notice: "Sell Complete"
    end

    private

    def check_customer_positions
        not_authorization unless current_user.positions.exists?(id: params[:id])
    end

    def check_customer_user_account
        not_authorization unless UserAccount.index_by_customer(current_user).exists?(id: params[:user_account_id]) 
    end

    def position_params
        params.require(:position).permit(:symbol, :shares, :user_account_id, :type, :value)
    end

    def equity_params
        params.require(:equity).permit(:symbol, :shares, :type)
    end

    def redirect_if_symbol_not_found(symbol)
        if Equity.lookup(symbol).class == IEX::Errors::SymbolNotFoundError
            redirect_to new_user_account_equity_path(@user_account), alert: "Symbol #{symbol} not found"
        end
    end

    def redirect_if_position_exist(symbol)
        if @user_account.positions.exists?(symbol: symbol)
            redirect_to new_user_account_equity_path(@user_account), alert: "You already have a position in #{symbol}"
        end
    end

    def create_position_or_redirect_if_purchase_not_valid(symbol, shares)
        redirect_if_position_exist(symbol)
        redirect_if_symbol_not_found(symbol)
        @equity = @user_account.positions.build(equity_params)
        if @equity.save
            if @equity.affordable?(symbol, shares)
                redirect_to equity_path(@equity), notice: "You purchased #{shares} share(s) of #{symbol} for $#{@equity.total_purchase_price(symbol, shares)}"
            else
                @equity.destroy
                redirect_to new_user_account_equity_path(@user_account), alert: "Insufficient Funds"
            end
        else
            render :new
        end
    end
    
end
