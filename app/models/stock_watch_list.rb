class StockWatchList < ApplicationRecord
    belongs_to :stock 
    belongs_to :watch_list
end
