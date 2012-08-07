require 'money-rails'
MoneyRails::Hooks.init
MoneyRails.configure do |config|
  config.include_validations = true
end

class IntegerMoneyRailsProduct < ActiveRecord::Base
  monetize :price_cents, :allow_nil => true, :model_currency => :usd
end
