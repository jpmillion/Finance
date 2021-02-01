class Position < ApplicationRecord
    belongs_to :user_account

    scope :user_account_balance, -> (user_account) { where(user_account: user_account).sum(:value) }
    scope :index_by_user_account, -> (user_account) { joins(:user_account).where(user_account: user_account) }

    def transaction(transaction: , cash_amount: 0, shares: 0)
        
        case transaction

        when "Deposit"
            self.value += cash_amount
            "Deposited $#{cash_amount} in your account"

        when "Withdrawl"
            if self.value > cash_amount
                self.value -= cash_amount
                "$#{cash_amount} withdrawn from your account"
            else
                "Withdrawl canceled: Insuffcient funds"
            end

        when "Add"
            if self.affordable?(self.symbol, shares)
                self.update(shares: self.shares + shares)
                "#{shares} share(s) have been added to your position"
            else
                 "Insufficient Funds"
            end
              
        else
            if self.shares > shares
                self.update(shares: self.shares - shares)
                user_account.get_paid(self.total_purchase_price(self.symbol, shares))
                "You have sold #{shares} share(s)"
            else
                "Sell canceled: You cannot sell more than you have (#{self.shares})"
            end
        end
    end
end
