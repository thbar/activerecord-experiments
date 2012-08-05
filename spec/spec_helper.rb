require 'active_record'
require 'rails/all'
require 'rspec/rails'
require 'shoulda'
require 'awesome_print'

lib_folder = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH << lib_folder

require 'decimal_price_product'

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true

  config.before(:all) do
    yaml = YAML.load_file('db/config.yml')['development']
    ActiveRecord::Base.establish_connection(yaml)

  end
end