class User < ApplicationRecord
    has_secure_password
    
    has_many :user_accounts, dependent: :destroy
    has_many :financial_products, through: :user_accounts
    has_many :positions, through: :user_accounts

    #validates :first_name, :last_name, :username, :email, presence: true
    validates :email, presence: true, uniqueness: true

    # before_validation :full_name


    def full_name
        (self.first_name + ' ' + self.last_name).titleize
    end

    def net_worth
        UserAccount.sum_user_account_balances(self)
    end
end
