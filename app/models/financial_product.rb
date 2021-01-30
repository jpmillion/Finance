class FinancialProduct < ApplicationRecord
    has_many :user_accounts
    has_many :users, through: :user_accounts

    validates :name, :description, presence: true
    validates :name, :description, uniqueness: true

    scope :acct_type_count, -> { joins(:user_accounts).group(:name).count }

end
