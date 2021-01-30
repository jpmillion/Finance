class Customer < User
    def net_worth
        UserAccount.sum_user_account_balances(self)
    end

    def self.full_service
        self.select {|customer| customer.net_worth > 1000000 }
    end


end
