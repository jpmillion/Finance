class StocksController < ApplicationController
    def index
        @quote = Stock.quote('qqq')['latest_price']
    end
end
