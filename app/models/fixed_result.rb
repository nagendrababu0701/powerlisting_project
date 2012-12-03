class FixedResult < ActiveRecord::Base
  attr_accessible :directory_partner_id, :issue_id, :status, :user_id
  belongs_to :user
 belongs_to :directory_partner
belongs_to :issue
end
