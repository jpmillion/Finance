class PositionsController < ApplicationController
    def new
        @position = Position.new(user_account_id: params[:user_account_id])
        @user_account = @position.user_account
    end

    def create
        #binding.pry
        @user_account = UserAccount.find_by(params[:position][:user_account_id])
        if @user_account.position_exists?(params[:position][:symbol])
            redirect_to new_user_account_position_path(@user_account), alert: "You already have a position in #{params[:position][:symbol]}"
        else 
            # position_hash = stock_quote(params[:position][:symbol], params[:position][:shares])
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


    def position_params
        params.require(:position).permit(:symbol, :shares, :user_account_id)
    end
end
