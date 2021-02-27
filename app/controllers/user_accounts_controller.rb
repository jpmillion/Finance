class UserAccountsController < ApplicationController

    before_action :check_user_account_authorization, except: [:show, :destroy]
    before_action :check_customer_user_account, only: [:show, :destroy]

    def index
        @user_accounts = UserAccount.index_by_customer(current_user)
    end

    def new
        @user_account = UserAccount.new
        @cash = @user_account.positions.build
        @products = FinancialProduct.all
    end

    def create
        fin_product = FinancialProduct.find_by(id: params[:user_account][:financial_product_id])
        if current_user.financial_products.exists?(id: fin_product.id)
            redirect_to new_customer_user_account_path(current_user), alert: "You already opened a #{fin_product.name}"
        else
            @user_account = current_user.user_accounts.create(user_account_params)
            redirect_to user_account_path(@user_account), notice: "You have successfully opened a #{fin_product.name}"
        end
    end

    def show
        @user_account = UserAccount.find_by(id: params[:id])
    end

    def destroy
        @user_account = UserAccount.find_by(id: params[:id])
        @user_account.destroy unless @user_account.nil?
        redirect_to customer_path(current_user), notice: "Account has been closed"
    end


    private

    def check_customer_user_account
        not_authorization unless UserAccount.index_by_customer(current_user).exists?(id: params[:id]) 
    end

    def check_user_account_authorization
        not_authorization unless current_user.id == params[:customer_id].to_i
    end

    def user_account_params
        params.require(:user_account).permit(:financial_product_id, positions_attributes: [:type, :value])
    end
end
