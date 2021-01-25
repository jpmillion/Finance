class FinancialProduct < ApplicationRecord
    has_many :user_accounts
    has_many :users, through: :user_accounts

    validates :name, :description, presence: true
    validates :name, :description, uniqueness: true
end
