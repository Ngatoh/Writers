class Purchase < ActiveRecord::Base

  validates  :user_id, :paper_id, presence: true
  belongs_to :user
  belongs_to :paper

  serialize :notification_params, Hash

  def paypal_url(return_url, paper)
  	values = {
  		business: "alexanderngatia-facilitator@gmail.com",
  		cmd: "_xclick",
  		upload: 1,
  		return: return_url,
  		invoice: id,
  		amount:  paper.price,
  		item_name: paper.topic,
  		item_number: paper.id,
  		quantity: '1'
      #notify_url: "#{Rails.application.secrets.app_host}/papershook"
  	}
  	  "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end

  #{}"#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
end
