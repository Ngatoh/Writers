class Message < ActiveRecord::Base
	validates :order_id, :user_id, :content, presence: true

#Relationships
  belongs_to :user
  belongs_to :order
end
