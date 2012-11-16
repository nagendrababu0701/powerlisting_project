class Directory < ActiveRecord::Base
  attr_accessible :business_lising_information, :business_location_id, :categories, :description, :photos, :special_offer, :status, :web_site
	belongs_to :business_location
end
