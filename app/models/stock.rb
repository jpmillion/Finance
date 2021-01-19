class Stock < ApplicationRecord
    has_many :stock_watch_lists
    has_many :watch_lists, through: :stock_watch_lists
end
