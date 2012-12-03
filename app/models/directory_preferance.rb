class DirectoryPreferance < ActiveRecord::Base
belongs_to :directory_partner
belongs_to :user
  attr_accessible :date, :directory_partner_id, :user_id
end
