class AddPriceToPapers < ActiveRecord::Migration
  def change
    add_column :papers, :price, :decimal
  end
end
