class AddHalfPriceToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :half_price, :decimal
  end
end
