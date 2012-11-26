require "rubygems"
 require "test/unit"
 require "net/https"
 #require 'yahoo/local_search'

 class UsersBusinessLocationsController < ApplicationController

def previous_information_details
user=User.current
if(user)
business_locations= BusinessLocation.last(:conditions=>"user_id= '#{user.id}'")
if(business_locations)
 @directories=Directory.find(:all, :conditions=>"business_location_id='#{business_locations.id}'")
end
	#@user=User.first(:conditions=>"firstname = '#{params[:user_id]}'", :include=>[{:business_locations=>[:directories]}])
end
end


def search_business_details
user=User.current
@name=user.firstname
@login_time=user.last_login_on

@s = Geocoder.search(params[:city],params[:business])

		client = Yelp::Client.new
    request = Yelp::Phone::Request::Number.new(
          :phone_number =>  params[:ph_no],
          :yws_id => 'GanonVA_293b8gzCHFgHdQ')
      response = client.search(request)
    @yelp_results=""

    for i in 0...response["businesses"].length
        if(response["businesses"][i]["zip"]==params[:pincode])
        request_results = Yelp::Review::Request::Location.new(
                    :address => response["businesses"][i]["address1"],
                    :city => response["businesses"][i]["city"],
                    :state => response["businesses"][i]["state"],
                    :term => response["businesses"][i]["name"],
                    :yws_id => 'GanonVA_293b8gzCHFgHdQ')
    		response_results = client.search(request_results)
        @yelp_results=response_results["message"]["text"]
      	end
    end
   

#yls = Yahoo::LocalSearch.new('0yJmk9cUNjYUg0RWhVOG1aJmQ9WVdrOVNUZEdkMjFrTXpJbWNHbzlNVEV4TVRJd05UWXkmcz1jb25zdW1lcnNlY3JldCZ4PWI')
#@yahoo_results = yls.locate params[:business], params[:pincode], 5

foursquare=Foursquare::Base.new('2LRH0UGPXER4KLVDBCOHZUNKKWWCM5JI0B2F05IDFUEREUMD','M4EK4OH2FMKH0WNFJYDPL2GWNAF1AOCTZ4YE1XFE22OQXN0H')
@venues = foursquare.venues.search(:query => params[:business], :ll => "48.857,2.349", :near => params[:city])

       business_location=BusinessLocation.new
       business_location.address = params[:address] 
       business_location.city = params[:city]
       business_location.state = params[:state]
       business_location.ph_no = params[:ph_no]
       business_location.business_name = params[:business]
       business_location.pincode = params[:pincode]
       business_location.user_id = user.id
       business_location.login_time = user.last_login_on 
       i=1
	     business_user_id=BusinessLocation.find_last_by_user_id(user.id)
       if(business_user_id)
	         business_location.logincount = business_user_id.logincount.to_i+1
	     else
	         business_location.logincount = i
       end
       business_location.save

directories= Directory.new
if(@s[0])
 directories.business_location_id=business_location.id
 directories.business="MAPQUEST"
 directories.business_lising_information=@s[0].formatted_address
 directories.categories=params[:business]
directories.status="Found"
directories.save
end
  
directories1= Directory.new
 if(@yelp_results=="OK")
    directories1.business_location_id=business_location.id
     directories1.business=response_results["businesses"][0]["name"]
     directories1.business_lising_information=params[:city]+","+params[:state]+","+params[:country]
     directories1.categories=response_results["businesses"][0]["categories"]
     directories1.web_site=response_results["businesses"][0]["url"]
     directories1.photos=response_results["businesses"][0]["photo_url"]
    directories1.status="Found"
    directories1.save
end

directories2= Directory.new
if(@venues)
  if(@venues["places"])
    if(@venues["places"][0].location["postalCode"]==params[:pincode])
     directories2.business_location_id=business_location.id
     directories2.business="Foursquare"
     directories2.business_lising_information=@venues["places"][0].location["city"]+","+@venues["places"][0].location["state"]
     directories2.categories=@venues["places"][0].categories
     directories2.photos=@venues["places"][0].icon
     directories2.status="Found"
    directories2.save
    end 
    end 
end

directories3= Directory.new
if(@yahoo_results)
  if(@yahoo_results[0].title)
     directories3.business_location_id=business_location.id
     directories3.business="Yahoo"
     directories3.business_lising_information=params[:city]+","+params[:state]+","+params[:country]
     directories3.categories=@yahoo_results[0].categories
     directories3.web_site=@yahoo_results[0].business_url
    directories3.status="Found"
    directories3.save
end
end

render :partial=>'users/business_info_search'
end


end
