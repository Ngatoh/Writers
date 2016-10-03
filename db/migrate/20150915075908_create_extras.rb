class CreateExtras < ActiveRecord::Migration
  def change
    create_table :extras do |t|
      t.string :material, null: false
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
