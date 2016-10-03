class AddAnsweredToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :answered, :boolean, default: false
  end
end
