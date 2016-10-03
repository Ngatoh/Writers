class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.references :user, index: true, foreign_key: true
      t.references :paper, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
