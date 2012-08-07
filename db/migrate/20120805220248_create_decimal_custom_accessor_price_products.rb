class CreateDecimalCustomAccessorPriceProducts < ActiveRecord::Migration
  def change
    create_table :decimal_custom_accessor_price_products do |t|
      t.decimal :amount, precision: 10, scale: 2
    end
  end
end
