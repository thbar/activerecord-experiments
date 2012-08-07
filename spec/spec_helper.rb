require 'active_record'
require 'rails/all'
require 'rspec/rails'
require 'shoulda'
require 'awesome_print'

lib_folder = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH << lib_folder

require 'decimal_price_product'
require 'decimal_custom_accessor_price_product'
require 'integer_money_rails_product'
require 'custom_money_product'
require 'composed_of_product'

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true

  config.before(:all) do
    yaml = YAML.load_file('db/config.yml')['development']
    ActiveRecord::Base.establish_connection(yaml)
  end
end