class TransactionsController < ApplicationController
    def new
        @transaction = Transaction.new
    end

    def create
        binding.pry
        stock.quote(params[:transaction][:name])
        params.new(transaction_params)
    end
end
