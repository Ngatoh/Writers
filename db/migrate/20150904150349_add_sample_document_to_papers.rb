class AddSampleDocumentToPapers < ActiveRecord::Migration
  def change
    add_column :papers, :sample_document, :string
  end
end
