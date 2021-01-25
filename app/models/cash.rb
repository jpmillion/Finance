class Cash < Position
    validates :value, numericaly: { greater_than_or_equal_to: 0 }
end
