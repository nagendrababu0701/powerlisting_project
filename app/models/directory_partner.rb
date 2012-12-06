class DirectoryPartner < ActiveRecord::Base
  #attr_accessible :description, :name, :preffered

has_and_belongs_to_many :users
has_many :search_results
has_many :fixed_results
end