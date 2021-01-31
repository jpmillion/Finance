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
end
