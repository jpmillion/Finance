class Equity < Position
    validates :symbol, presence: true
    validates :symbol, uniqueness: { scope: :user_account }
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

    def self.lookup(symbol)
        res = IEX::Api::Client.new(
            publishable_token: ENV['IEX_API_PUBLISHABLE_TOKEN'],
            secret_token: ENV['IEX_API_SECRET_TOKEN'],
            endpoint: 'https://cloud.iexapis.com/v1'
        ).quote(symbol)
    end

    def share_price(symbol)
        Equity.lookup(symbol).latest_price
    end

    def total_value(symbol)
        self.share_price(symbol) * self.shares
    end

    def total_purchase_price(symbol, shares)
        self.share_price(symbol) * shares
    end

    def company_name(symbol)
        Equity.lookup(symbol).company_name
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
