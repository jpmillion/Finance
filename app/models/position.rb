class Position < ApplicationRecord
    belongs_to :user_account
    validates :symbol, :shares, presence: true
end
