class User < ApplicationRecord
    has_secure_password
    
    has_many :user_accounts
    has_many :financial_products, through: :user_accounts

    validates :first_name, :last_name, :username, :email, presence: true
    validates :username, :email, uniqueness: true
end
