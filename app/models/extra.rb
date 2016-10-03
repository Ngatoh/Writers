class Extra < ActiveRecord::Base
  belongs_to :order

  mount_uploader :material, MaterialUploader
end
