class AddParamsStatusTransactionIdPurchasedAtToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :notification_params, :text
    add_column :purchases, :status, :string
    add_column :purchases, :transaction_id, :string
    add_column :purchases, :purchased_at, :datetime
  end
end
