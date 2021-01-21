class Stock < ApplicationRecord
    has_many :stock_watch_lists
    has_many :watch_lists, through: :stock_watch_lists

    def self.quote(symbol)
        IEX::Api::Client.new(
            publishable_token: 'pk_02f29690e23d4897b4b7916f6e78d39e',
            secret_token: 'sk_a74468b214424b4c825232000f18608c',
            endpoint: 'https://cloud.iexapis.com/v1'
          ).quote(symbol)
    end
end
