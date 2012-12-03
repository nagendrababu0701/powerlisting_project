class DirectoryPartner < ActiveRecord::Base
  attr_accessible :description, :name, :preffered
has_many :directory_preferences
has_many :users,:through =>:directory_preferences
has_many :search_results
has_many :fixed_results
end
