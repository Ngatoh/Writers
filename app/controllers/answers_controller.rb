class AnswersController < ApplicationController
	include Downloadable
	before_action :admin_user,   only: [:create]
	before_action :set_document, only: [:downloadanswer]
	protect_from_forgery except: [:answershook]

	def create
		@order = Order.find(params[:order_id])
		@answer = @order.build_answer(answer_params)		
		if @answer.save
			@order.answer
			flash[:success] = "You have successfully posted your answer"
			redirect_to @order
		else
			render 'orders/show'
		end		
	end

	def pay_fully
		@order = Order.find(params[:format])
		@answer= Answer.find_by(order_id: params[:format])
		if @answer
			redirect_to @answer.paypal_url(@order, @answer)
		else
			flash[:danger] = "Unknown action"
			redirect_to root_url
		end
	end

	def answershook
	    params.permit! # Permit all Paypal input params
	    status = params[:payment_status]
	    if status == "Completed"
	      @answer = Answer.find params[:invoice]
	      @answer.update_columns(notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now)
	      @order= Order.find_by(id: @answer.order_id)
	      @order.update_attribute(fully_paid: true)
	    end
	    render nothing: true
  end

  def downloadanswer
		  if !@answer.attachment.url.nil?
		    send_to_user(filepath: "public#{@answer.attachment.url}")
		  else
		  	flash[:info]='Unfortunately the requested file does not exist'
  			return redirect_to :back 
		  end  	
  end


	private
	def answer_params
		params.require(:answer).permit(:order_id, :attachment)
	end

	def set_document
		@order= Order.find(params[:id])
		@answer = Answer.find_by(order_id: @order.id)
	end
end
