class Order < ActiveRecord::Base
  belongs_to :user
  validates  :user_id, :type_of_paper, :topic, :pages, :deadline, :discipline, :type_of_service,
										:format, :paper_instructions, presence: true
  validate  :check_deadline


#Relationships
  has_many :extras, dependent: :destroy
  accepts_nested_attributes_for :extras, allow_destroy: true
  has_one :answer, dependent: :destroy 
  has_many :messages, dependent: :destroy



#Sets the price
	def set_price
  		if self.deadline > 14.days.from_now
			calculate_price(self.pages, 7 )
  		elsif self.deadline >= 7.days.from_now 
  			calculate_price(self.pages, 10 )
  		elsif self.deadline >= 5.days.from_now
  			calculate_price(self.pages, 15 )
  		elsif self.deadline >=48.hours.from_now
  			calculate_price(self.pages, 20 )
  		elsif self.deadline >= 24.hours.from_now 
  			calculate_price(self.pages, 25 )
  		elsif self.deadline  >= 12.hours.from_now 
  			calculate_price(self.pages, 30 )
  		elsif self.deadline  >= 6.hours.from_now 
  			calculate_price(self.pages, 33 )
  		elsif self.deadline <  6.hours.from_now
  			calculate_price(self.pages, 34 )
  		end	
  	end

  	def calculate_price(number_of_pages, price_per_page)
  		price = (number_of_pages).to_f * (price_per_page).to_f
  		half_price = price/2.to_f
  		update_columns(price: price, half_price: half_price)
  	end


  serialize :notification_params, Hash

  def paypal_url(return_url)
  	values = {
  		business: "alexanderngatia-facilitator@gmail.com",
  		cmd: "_xclick",
  		upload: 1,
  		return: return_url,
  		invoice: id,
  		amount:  half_price,
  		item_name: topic,
  		item_number: id,
  		quantity: '1'
      #notify_url: "#{Rails.application.secrets.app_host}/ordershook"
  	}
  	  "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end

  def answer
    update_attribute(:answered, true)
  end


private

#Checks the deadline is from today onwards
	def check_deadline
	  if self.deadline < Time.now
	  	errors.add(:deadline, "should be valid date")
      end
	end
end
