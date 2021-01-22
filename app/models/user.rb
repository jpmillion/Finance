class User < ApplicationRecord
    has_secure_password
    has_many :user_accounts
    has_many :financial_products, through: :user_accounts
    has_many :watch_lists
    has_many :stocks

    validates :first_name, :last_name, :username, :email, :password_digest, presence: true
end
