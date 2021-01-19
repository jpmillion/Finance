class WatchList < ApplicationRecord
    has_many :stock_watch_lists
    has_many :stocks, through: :stock_watch_lists
end
