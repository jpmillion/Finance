class Position < ApplicationRecord
    belongs_to :user_account

    def transaction(transaction, value=0, shares=0)
        
        case transaction

        when "Deposit"
            self.value += value
            if self.save
                "Deposited $#{value} in your account"
            end
        when "Withdrawl"
            if self.value > value
                self.value -= value
                if self.save
                    "$#{value} withdrawn from your account"
                end
            else
                "Withdrawl canceled: Insuffcient funds"
            end
        when "Add"
            self.shares += shares
            if self.save
                "#{shares} share(s) have been added to your position"
            end
        else
            if self.shares > shares
                self.shares -= shares
                if self.save
                    "You have sold #{shares} share(s)"
                end
            else
                "Sell canceled: You cannot sell more than you have (#{self.shares})"
            end
        end
    end
end
