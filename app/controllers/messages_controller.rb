class MessagesController < ApplicationController
	before_action :logged_in_user

	def create
		@order = Order.find(params[:order_id])
		@message = @order.messages.build(message_params)
		@message.user = current_user
		if @message.save!

			@path = order_path(@order)

			respond_to do |format|
  				format.html {redirect_to @order}
  				format.js 
  	  		end
		else
			respond_to do |format|
  				format.html {render 'orders/show'}
  				format.js
  			end			
		end
	end
	
  private

  def message_params
  	params.require(:message).permit(:order_id, :content)
  end
end
