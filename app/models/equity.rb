class Equity < Position
    validates :symbol, presence: true
    validates :shares, numericality: { greater_than_or_equal_to:  0, only_integer: true }
end
