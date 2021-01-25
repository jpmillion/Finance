class UserAccount < ApplicationRecord
    belongs_to :user
    belongs_to :financial_product
    has_many :positions

    
        
    def position_exists?(symbol)
        self.positions.where(symbol: symbol.upcase) == [] ? false : true
    end

    def cash_position_exist?
        !!user_account.positions.where(type: 'Cash')
    end
end
