class UserAccountsController < ApplicationController

    def new
        @user = current_user
        @user_account = UserAccount.new
        @cash = @user_account.positions.build
        @products = FinancialProduct.all
    end

    def create
        fin_product = FinancialProduct.find_by(id: params[:user_account][:financial_product_id])
        if current_user.financial_products.include?(fin_product)
            redirect_to new_customer_user_account_path(current_user), alert: "You already opened a #{fin_product.name}"
        else
            @user_account = UserAccount.create(user_account_params)
            redirect_to customer_user_account_path(current_user, @user_account), alert: "You have successfully opened a #{fin_product.name}"
        end
    end

    def show
        @user_account = UserAccount.find_by(id: params[:id])
    end

    def destroy
        @user_account = UserAccount.find_by(id: params[:id])
        @user_account.destroy
        redirect_to customer_path(current_user), alert: "Account has been closed"
    end


    private

    def user_account_params
        params.require(:user_account).permit(:financial_product_id, :user_id, :cash_attributes [:value])
    end
end
