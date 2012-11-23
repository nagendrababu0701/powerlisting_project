class UsersBusinessLocationsController < ApplicationController

	def previous_information_details
user=User.current
if(user)
business_locations= BusinessLocation.last(:conditions=>"user_id= '#{user.id}'")
puts 
if(business_locations)
 @directories=Directory.find(:all, :conditions=>"business_location_id='#{business_locations.id}'")
end
	#@user=User.first(:conditions=>"firstname = '#{params[:user_id]}'", :include=>[{:business_locations=>[:directories]}])
end
end

end
