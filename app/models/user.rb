class User < ApplicationRecord
    has_many :user_accounts
    has_many :financial_products, through: :user_accounts
    has_many :watch_lists
    has_many :stocks
end
