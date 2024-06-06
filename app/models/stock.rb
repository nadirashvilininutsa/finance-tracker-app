class Stock < ApplicationRecord
  def self.new_lookup(ticker_symbol)
    Alphavantage.configure do |config|
      config.api_key = Rails.application.credentials.alphavantage_api_key
    end
    
    begin
      client = Alphavantage::TimeSeries.new(symbol: ticker_symbol).quote
      company = Alphavantage::Fundamental.new(symbol: 'TSLA').overview
      new(ticker: ticker_symbol, name: company.name, last_price: client.open)
    rescue => exception
      return nil
    end  

  end
end