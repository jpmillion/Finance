class UserAccountsController < ApplicationController

    def new
        @user = current_user
        @user_account = UserAccount.new
        @products = FinancialProduct.all
    end

    def create
        binding.pry
        @user_account = UserAccount.create(user_account_params)
        redirect_to user_path(current_user)
    end

    def show
        @user_account = UserAccount.find_by(id: params[:id])
    end


    private

    def user_account_params
        params.require(:user_account).permit(:financial_product_id, :user_id)
    end
end
