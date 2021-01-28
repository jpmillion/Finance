class PositionsController < ApplicationController
    def new
        @position = Position.new(user_account_id: params[:user_account_id])
        @user_account = @position.user_account
    end

    def create
        #binding.pry
        @user_account = UserAccount.find_by(id: params[:position][:user_account_id])
        if params[:position][:symbol] != '' && @user_account.position_exists?(params[:position][:symbol])
            redirect_to new_user_account_position_path(@user_account), alert: "You already have a position in #{params[:position][:symbol]}"
        elsif params[:position][:type] == 'Cash' && @user_account.cash_position_exist?
            redirect_to new_user_account_position_path(@user_account), alert: "Only 1 cash position per account"
            # position_hash = stock_quote(params[:position][:symbol], params[:position][:shares])
        else
            @position = @user_account.positions.build(position_params)
            if @position.save
                redirect_to user_account_position_path(@user_account, @position)
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


    def position_params
        params.require(:position).permit(:symbol, :shares, :user_account_id, :type, :value)
    end
end
