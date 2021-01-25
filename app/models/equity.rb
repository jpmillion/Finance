class Equity < Position
    validates :symbol, presence: true
    validates :shares, numericality: { greater_than:  0, only_integer: true }
end
