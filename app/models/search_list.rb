class SearchList < ActiveRecord::Base
  attr_accessible :business_name, :city, :country, :ph_no, :pin_code, :state, :user_id
belongs_to :user
has_many :search_results

end
