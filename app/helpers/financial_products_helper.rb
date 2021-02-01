module FinancialProductsHelper

    def display_sums_of_products(k, v) 
        content_tag(:p, "#{k} : #{v}")
    end

    def display_net_worth_of_customer(customer)
        content_tag(:p, "#{customer.full_name} : net worth #{number_to_currency(customer.net_worth)}")  
    end
end
