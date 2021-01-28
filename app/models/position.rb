class Position < ApplicationRecord
    belongs_to :user_account

    def transaction(transaction, value=0, shares=0)
        
        case transaction

        when "Deposit"
            self.value += value
            "Deposited $#{value} in your account"

        when "Withdrawl"
            if self.value > value
                self.value -= value
                "$#{value} withdrawn from your account"
            else
                "Withdrawl canceled: Insuffcient funds"
            end

        when "Add"
            self.shares += shares
            "#{shares} share(s) have been added to your position"
            
        else
            if self.shares > shares
                self.shares -= shares
                "You have sold #{shares} share(s)"
            else
                "Sell canceled: You cannot sell more than you have (#{self.shares})"
            end
        end
    end
end
