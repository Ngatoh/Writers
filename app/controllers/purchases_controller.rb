class PurchasesController < ApplicationController
	before_action   :logged_in_user, only: [:create]

	before_action   :set_purchase, only: [:show]

	protect_from_forgery except: [:papershook]

	def show
		@paper = Paper.find_by(id: @purchase.paper_id)
	end
	
	
	def create
		@purchase = current_user.purchases.create(purchase_params)
		paper = Paper.find_by(id: params[:purchase][:paper_id])
		if @purchase.save
			redirect_to @purchase.paypal_url(purchase_path(@purchase), paper)
		else
			flash[:danger] = "Sorry!. There seems to be a problem with this order."
			render 'papers/showcompletedpapers'
		end
	end

	def finishpayment
		@paper = Paper.find(params[:format])
		@purchase = @paper.purchases.find_by(id: current_user.id)
		if @purchase
			redirect_to @purchase.paypal_url(purchase_path(@purchase), @paper)
		else
			flash[:danger] = "Unknown action"
			redirect_to root_url and return
		end
	end


  def papershook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"
      @purchase = Purchase.find params[:invoice]
      @purchase.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
    end
    render nothing: true
  end


	private
	def purchase_params
		params.require(:purchase).permit(:user_id, :paper_id)
	end

	def set_purchase
		@purchase = Purchase.find(params[:id])
	end
end
