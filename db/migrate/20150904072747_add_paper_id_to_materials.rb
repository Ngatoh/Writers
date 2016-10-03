class AddPaperIdToMaterials < ActiveRecord::Migration
  def change
    add_reference :materials, :paper, index: true, foreign_key: true
  end
end
