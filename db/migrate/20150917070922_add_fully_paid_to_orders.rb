class AddFullyPaidToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :fully_paid, :boolean, default: false
  end
end
