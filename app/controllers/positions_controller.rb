class PositionsController < ApplicationController
    def new
        @position = Position.new(user_account_id: params[:user_account_id])
        @user_account = @position.user_account
    end

    def create
        binding.pry
        user_account = UserAccount.find_by(params[:position][:user_account_id])
        position_hash = stock_quote(params[:position][:symbol], params[:position][:shares])
        position = user_account.positions.create(position_hash)

        redirect_to user_account_position_path(user_account, position)
    end

    def show
        @position = Position.find_by(id: params[:id])
    end
end
