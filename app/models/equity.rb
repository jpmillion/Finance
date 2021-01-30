class Equity < Position
    validates :symbol, presence: true
    validates :shares, numericality: { greater_than_or_equal_to:  0, only_integer: true }

    scope :user_account_equity_value, -> (user_account) { where(user_account: user_account).sum(:value) }

    before_validation do
        self.symbol = self.symbol.upcase if self.symbol
    end

    def equity_value
        self.update(value: self.total_value(self.symbol))
    end
end
