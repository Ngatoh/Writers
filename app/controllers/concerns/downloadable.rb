module Downloadable extend ActiveSupport::Concern

  def send_to_user(args={})
  	file = args[:filepath]
   	if File.exists?(file) and File.readable?(file)
	      send_file file
	    else
	      flash[:info]='Unfortunately the requested file is not readable or cannot be located.'
	      redirect_to :back
	end
  end
end