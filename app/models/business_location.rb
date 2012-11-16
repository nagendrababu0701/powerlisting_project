class BusinessLocation < ActiveRecord::Base
  attr_accessible :business_name, :city, :country, :login_time, :pincode, :state, :user_id
belongs_to :user
 has_many :directories, :dependent => :destroy

end
