# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

DirectoryPartner.create(:name=>"YELP",:description => "desc",:preffered => true)
DirectoryPartner.create(:name=>"YAHOO",:description => "desc",:preffered => false)
DirectoryPartner.create(:name=>"FOURSQUARE",:description => "desc",:preffered => true)