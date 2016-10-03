class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.string :type_of_paper
      t.string :topic
      t.integer :pages
      t.datetime :deadline
      t.string :discipline
      t.string :type_of_service
      t.string :format
      t.text :paper_instructions

      t.timestamps null: false
    end
  end
end
