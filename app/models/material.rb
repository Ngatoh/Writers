class Material < ActiveRecord::Base
  belongs_to :paper
  validates  :paper_id, presence: true

  mount_uploader  :additional_materials, AdditionalMaterialsUploader
end
