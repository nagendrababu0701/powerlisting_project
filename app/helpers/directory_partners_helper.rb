module DirectoryPartnersHelper
	def user_directory(dir_name,prefered_api)
		return false if prefered_api.blank?
		checked = prefered_api.include?(dir_name) ? true : false
		return checked
    end		
end
