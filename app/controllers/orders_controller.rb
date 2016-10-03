class OrdersController < ApplicationController
	before_action   :logged_in_user, only: [:show, :create]
	before_action   :admin_user,     only: [:index]
  	before_action   :correct_user,   only: [:show]
  	protect_from_forgery except: [:ordershook]

  	def show
  	 	@materials = @order.extras
  	 	@messages = @order.messages.paginate(page: params[:page])
  	 	@path     = order_path(@order)
  	end

  	def new
  	 	@paper = Paper.find(params[:format])
  	 	@order = current_user.orders.build
  	end

	def create
		@order = current_user.orders.build(order_params)
		if @order.save
       		@order.set_price
			redirect_to @order.paypal_url(order_path(@order))
		else
			render 'users/new'
		end
	end

	def destroy
		
	end


	def ordershook
	    params.permit! # Permit all Paypal input params
	    status = params[:payment_status]
	    if status == "Completed"
	      @order = Order.find params[:invoice]
	      @order.update_columns(notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now)
	    end
	    render nothing: true
    end


	private

	def order_params
		params.require(:order).permit(:type_of_paper, :topic, :pages, :deadline, :discipline, :type_of_service,
										:format, :paper_instructions, extras_attributes: [:material])
	end

	def correct_user
		if current_user.admin?
			@order = Order.find(params[:id])
	   else
	   	   @order = Order.find(params[:id])
		    @user = User.find(@order.user_id)
		    redirect_to(root_url) unless current_user?(@user)
		end
  	end

end
