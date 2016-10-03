class Paper < ActiveRecord::Base
	validates :type_of_paper, :topic,:pages, :discipline, :format, :paper_instructions, presence: true	
	validates :document, presence: true

	mount_uploader  :document, DocumentUploader
	
	mount_uploader  :sample_document, SampleDocumentUploader
	
	has_many :materials,  dependent: :destroy
	has_many :purchases,  dependent: :destroy
	has_many :users, through: :purchases

	accepts_nested_attributes_for :materials, allow_destroy: true

	def set_price
		price = (self.pages).to_f * 2.5 
		update_attribute(:price, price)
	end
 
end
