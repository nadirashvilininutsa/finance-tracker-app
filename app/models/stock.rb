class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true
  
  def self.new_lookup(ticker_symbol)
    Alphavantage.configure do |config|
      config.api_key = Rails.application.credentials.alphavantage_api_key
    end
    
    begin
      client = Alphavantage::TimeSeries.new(symbol: ticker_symbol).quote
      company = Alphavantage::Fundamental.new(symbol: ticker_symbol).overview
      new(ticker: ticker_symbol, name: company.name, last_price: client.open)
    rescue => exception
      return nil
    end  
  end

  def self.check_db(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
end