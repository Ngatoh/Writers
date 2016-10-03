class MaterialsController < ApplicationController
	before_action   :logged_in_user
	before_action   :admin_user  


	def create
	    @material = Material.new(material_params)
	    @material.save
  	end


  	private
  	def material_params
  		params.require(:material).permit(:paper_id, :additional_materials)
  	end
end
