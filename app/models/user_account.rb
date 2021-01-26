class UserAccount < ApplicationRecord
    belongs_to :user
    belongs_to :financial_product
    has_many :positions
    accepts_nested_attributes_for :cash

    
        
    def position_exists?(symbol)
        self.positions.where(symbol: symbol.upcase) == [] ? false : true
    end

    def cash_position_exist?
        !!self.positions.where(type: 'Cash')
    end
end
