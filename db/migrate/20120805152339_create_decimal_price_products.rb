class CreateDecimalPriceProducts < ActiveRecord::Migration
  def change
    create_table :decimal_price_products do |t|
      t.decimal :price, precision: 10, scale: 2
    end
  end
end
