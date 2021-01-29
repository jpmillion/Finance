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

    @@lookup = IEX::Api::Client.new(
        publishable_token: 'pk_02f29690e23d4897b4b7916f6e78d39e',
        secret_token: 'sk_a74468b214424b4c825232000f18608c',
        endpoint: 'https://cloud.iexapis.com/v1'
    )

    def share_price(symbol)
        @@lookup.quote(symbol).latest_price
    end

    def total_value(symbol)
        self.share_price(symbol) * self.shares
    end

    def total_purchase_price(symbol, shares)
        self.share_price(symbol) * shares
    end

    def company_name(symbol)
        @@lookup.quote(symbol).company_name
    end

    def affordable?(symbol, shares)
        balance, total_price = self.user_account.cash_balance, self.total_purchase_price(symbol, shares)
        if balance > total_price 
            self.user_account.make_payment(total_price)
        else
            false
        end   
    end
end
