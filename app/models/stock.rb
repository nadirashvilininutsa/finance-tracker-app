class Stock < ApplicationRecord
  # def self.new_lookup(ticker_symbol)
  #   client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
  #                                 endpoint: 'https://sandbox.iexapis.com/v1')
  #   client.price(ticker_symbol)
  # end

  def self.new_lookup(ticker_symbol)
    Alphavantage.configure do |config|
      config.api_key = Rails.application.credentials.alphavantage_api_key
    end
    client = Alphavantage::TimeSeries.new(symbol: ticker_symbol).quote
    client.open
  end
end