class UserAccount < ApplicationRecord
    belongs_to :user
    belongs_to :financial_product
    has_many :positions
end
