class SearchResult < ActiveRecord::Base
  attr_accessible :directory_partner_id, :search_list_id
belongs_to :search_list
belongs_to :directory_partner

end
