class AddParamsStatusTransactionIdPurchasedAtToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :notification_params, :text
    add_column :answers, :status, :string
    add_column :answers, :transaction_id, :string
    add_column :answers, :purchased_at, :datetime
  end
end
