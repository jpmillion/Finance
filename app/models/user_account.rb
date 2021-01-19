class UserAccount < ApplicationRecord
    belongs_to :user
    belongs_to :financial_product
end
