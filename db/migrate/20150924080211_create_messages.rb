class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :order_id
      t.integer :user_id
      t.text :content

      t.timestamps null: false
    end
  end
end
