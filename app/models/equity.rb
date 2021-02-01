class Equity < Position
    validates :symbol, presence: true
    validates :shares, numericality: { greater_than_or_equal_to:  0, only_integer: true }

    before_validation do
        self.symbol = self.symbol.upcase if self.symbol
    end

    after_find do
        self.update(value: self.total_value(self.symbol))
    end

    def cash_from_sell
        user_account.get_paid(total_purchase_price(symbol, shares))
        user_account
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
