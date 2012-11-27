class UsersBusinessLocation < ActiveRecord::Base
  # attr_accessible :title, :body


	def directory_savings(bus_id,business,business_lising_information,status)
  	directories= Directory.new
    directories.business_location_id=bus_id
	directories.business=business
	directories.business_lising_information=business_lising_information
	directories.status=status
	directories.save
	end

end
