class AddDocumentToPapers < ActiveRecord::Migration
  def change
    add_column :papers, :document, :string
  end
end
