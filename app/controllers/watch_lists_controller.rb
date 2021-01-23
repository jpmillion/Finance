class WatchListsController < ApplicationController

    def new
        @watchlist = WatchList.new
    end
end
