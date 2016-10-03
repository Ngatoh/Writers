class Answer < ActiveRecord::Base

  validates  :order_id, :attachment, presence: true
  belongs_to :order

  mount_uploader :attachment, AttachmentUploader

   serialize :notification_params, Hash

  def paypal_url(order, answer)
  	values = {
  		business: "alexanderngatia-facilitator@gmail.com",
  		cmd: "_xclick",
  		upload: 1,
  		#return: return_url, TODO
  		invoice: answer.id,
  		amount:  order.half_price,
  		item_name: order.topic,
  		item_number: order.id,
  		quantity: '1'
      #notify_url: "#{Rails.application.secrets.app_host}/answershook"
  	}
  	  "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end

  #{}"#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
end
