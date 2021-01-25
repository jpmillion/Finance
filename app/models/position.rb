class Position < ApplicationRecord
    belongs_to :user_account
    validates :symbol, presence: true
    validates :shares, numericality: { greater_than:  0, only_integer: true }
end
