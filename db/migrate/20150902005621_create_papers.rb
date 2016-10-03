class CreatePapers < ActiveRecord::Migration
  def change
    create_table :papers do |t|
      t.string :type_of_paper
      t.string :topic
      t.integer :pages
      t.string :discipline
      t.boolean :free, default: false
      t.string :format
      t.text :paper_instructions

      t.timestamps null: false
    end
  end
end
