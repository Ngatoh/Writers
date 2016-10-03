module UsersHelper

	def ispaperpaid?(paper)
		@purchase = paper.purchases.find_by(user_id: current_user.id)
		if @purchase.status=="completed"	
			return true
		else
			return false
		end	
	end

end
