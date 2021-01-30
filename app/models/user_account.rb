class UserAccount < ApplicationRecord
    belongs_to :user
    belongs_to :financial_product
    has_many :positions, dependent: :destroy
    accepts_nested_attributes_for :positions

    
        
    # def position_exists?(symbol)
    #     self.positions.where(symbol: symbol.upcase) == [] ? false : true
    # end

    # def cash_position_exist?
    #     !!self.positions.where(type: 'Cash')
    # end

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
