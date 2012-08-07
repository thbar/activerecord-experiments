class CreateIntegerMoneyRailsProducts < ActiveRecord::Migration
  def change
    create_table :integer_money_rails_products do |t|
      t.integer :price_cents
    end
  end
end
