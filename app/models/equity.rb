class Equity < Position
    validates :symbol, presence: true
    validates :shares, numericality: { greater_than_or_equal_to:  0, only_integer: true }

    before_validation do
        self.symbol = self.symbol.upcase if self.symbol
    end
end
