class ExtrasController < ApplicationController
	include Downloadable
	before_action   :logged_in_user
	before_action   :set_document,   only: [:download]


	def create
	    @extra = Extra.new(extra_params)
	    @extra.save
  	end

  	def download
  		if !@document.material.url.nil?
		    send_to_user(filepath: "public#{@document.material.url}")
		 else
		  	flash[:info]='Unfortunately the requested file does not exist'
  			return redirect_to :back 
		end
  	end

  	private
  	def extra_params
  		params.require(:extra).permit(:order_id, :material)
  	end

  	def set_document
		@order= Order.find(params[:format])
		document = Extra.find_by(id: params[:id])
		if document && document.order_id == @order.id
			@document = document
		else
			flash[:info]='Unfortunately the requested file does not exist'
  			return redirect_to :back 
  		end
  	end
end
