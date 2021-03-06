class UserAccount < ApplicationRecord
    belongs_to :user
    belongs_to :financial_product
    has_many :positions, dependent: :destroy
    accepts_nested_attributes_for :positions

    scope :sum_user_account_balances, -> (user) { where(user: user).sum(:balance) }
    scope :index_by_customer, -> (user) { joins(:user, :financial_product).where(user: user) }

    after_find do
        self.update(balance: Position.user_account_balance(self))
    end

    def cash_position
        positions.first
    end

    def cash_balance
        cash_position.value
    end

    def make_payment(payment)
        cash_position.update(value: cash_balance - payment)
    end

    def get_paid(payment)
        cash_position.update(value: cash_balance + payment)
    end

end
