class Materials < ActiveRecord::Migration
  def change
  	create_table :materials do |t|
      t.string :additional_materials
    

      t.timestamps null: false
    end
  end
end
