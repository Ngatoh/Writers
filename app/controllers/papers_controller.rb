class PapersController < ApplicationController
	include Downloadable
	before_action   :logged_in_user, only: [:create, :destroy]
	before_action   :admin_user,     only: [:create, :destroy]
	before_action   :set_document,   only: [:show, :download, :downloadsample]

	def show
		
	end

	def showfreepapers
		@papers = Paper.where("free = ?", true).paginate(page: params[:page])
	end

	def showcompletedpapers
		@papers = Paper.where("free = ?", false).paginate(page: params[:page])
	end

	def create
		@paper = Paper.new(paper_params)
		if @paper.save
			@paper.set_price
			if params[:paper][:free] == '1' 
				@paper.update_attribute(:free, true)
			end
				
			if params[:additional_materials]
        		params[:additional_materials].each { |material|
          	@paper.materials.create(additional_materials: material)
       		 }
       		end
			flash[:success] = "Upload successfull."
			redirect_to current_user
		else
			render 'users/show'
		end
	end

	def destroy
		Paper.find(params[:id]).destroy
    	flash[:success] = "Paper removed"
    	redirect_to current_user 
	end

#Download a free paper action
	  def download
		  if !@paper.document.url.nil?
		    send_to_user(filepath: "public#{@paper.document.url}")
		  else
		  	flash[:info]='Unfortunately the requested file does not exist'
  			return redirect_to :back 
		  end
	  end

#Download a sample document
	def downloadsample
		if !@paper.sample_document.url.nil?
		   send_to_user(filepath: "public#{@paper.sample_document.url}")
		else
		  flash[:info]='Unfortunately the requested file does not exist'
  		  return redirect_to :back 
		end
	end

	private
	def paper_params
		params.require(:paper).permit(:type_of_paper, :topic, :pages, :discipline,
								:format, :paper_instructions, :document, :sample_document)
	end
#Set the document to download
	def set_document
		@paper= Paper.find(params[:id])
	end
end
