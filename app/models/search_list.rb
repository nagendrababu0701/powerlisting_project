class SearchList < ActiveRecord::Base
attr_accessible :business_name, :city, :country, :ph_no, :pin_code, :state, :user_id
belongs_to :user
has_many :search_results

def directory_savings(options={})
  	directories= SearchResult.new
    directories.search_list_id=options[:search_id]
    directory_partner=DirectoryPartner.find_by_name(options[:directory_name])
  	directories.directory_partner_id=directory_partner.id
	directories.save
	end

end
