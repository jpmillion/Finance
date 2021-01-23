class FinancialProductsController < ApplicationController
    skip_before_action :login_required

    def index
        @products = FinancialProduct.all
    end
end
