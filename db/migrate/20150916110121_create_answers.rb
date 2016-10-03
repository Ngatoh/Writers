class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :order, index: true, foreign_key: true
      t.string :attachment, null: false

      t.timestamps null: false
    end
  end
end
