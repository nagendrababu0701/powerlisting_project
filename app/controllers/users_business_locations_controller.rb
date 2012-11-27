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

def bussiness_details_search
user=User.current
@name=user.firstname
@login_time=user.last_login_on
@business_user_id=BusinessLocation.find_by_user_id(user.id)
end

def select_states
s=state_select('business_location', 'state', country= params[:country], options = {}, html_options = {})
render :text => s
end


def search_business_details
user=User.current
address=""
address=user.address1 if user

@name=user.firstname
@login_time=user.last_login_on

phone=params[:ph_no].to_s
city=params[:city].to_s
business=params[:business].to_s
state=params[:business_location].to_s
country=params[:country].to_s
pincode=params[:pincode].to_s
match=phone

if !phone.blank? && !city.blank?
e1=Net::HTTP.get(URI.parse(URI.escape("http://api.yelp.com/phone_search?phone="+phone+"&ywsid=GanonVA_293b8gzCHFgHdQ")))
search_address=JSON.parse(e1)
   if(search_address["businesses"][0]["address1"].include?(city) || search_address["businesses"][0]["city"].include?(city) )
        @response_results=search_address 
        @yelp_results=@response_results["message"]["text"]
   end
elsif !phone.blank?
e=Net::HTTP.get(URI.parse(URI.escape("http://api.yelp.com/phone_search?phone="+phone+"&ywsid=GanonVA_293b8gzCHFgHdQ")))
@response_results=JSON.parse(e)
@yelp_results=@response_results["message"]["text"]
elsif !city.blank?
e=Net::HTTP.get(URI.parse(URI.escape("http://api.yelp.com/business_review_search?term="+business+"&location="+address+","+city+","+country+","+pincode+"&ywsid=GanonVA_293b8gzCHFgHdQ")))
@response_results=JSON.parse(e)
@yelp_results=@response_results["message"]["text"]
end

#yls = Yahoo::LocalSearch.new('0yJmk9cUNjYUg0RWhVOG1aJmQ9WVdrOVNUZEdkMjFrTXpJbWNHbzlNVEV4TVRJd05UWXkmcz1jb25zdW1lcnNlY3JldCZ4PWI')
#@yahoo_results = yls.locate params[:business], params[:pincode], 5
debugger
foursquare=Foursquare::Base.new('2LRH0UGPXER4KLVDBCOHZUNKKWWCM5JI0B2F05IDFUEREUMD','M4EK4OH2FMKH0WNFJYDPL2GWNAF1AOCTZ4YE1XFE22OQXN0H')
@s = Geocoder.search(city+","+state+","+country+","+pincode)
@venues = foursquare.venues.search(:query => params[:business], :ll => @s[0].latitude.to_s+","+@s[0].longitude.to_s, :intent => :match)



business_location=BusinessLocation.new(:address=> params[:address], :city => params[:city], :state=> params[:business_location], :ph_no => params[:ph_no], :business_name=>params[:business], :pincode => params[:pincode], :user_id => user.id, :login_time => user.last_login_on)
business_location.save

u=UsersBusinessLocation.new
u.directory_savings(business_location.id,"MAPQUEST",@s[0].formatted_address,"Found")

 if(@yelp_results=="OK")
   u.directory_savings(business_location.id,@response_results["businesses"][0]["name"],@response_results["businesses"][0]["city"]+","+@response_results["businesses"][0]["state"],"Found")
end

if(@venues)
  if(@venues["places"])
   u.directory_savings(business_location.id,"Foursquare",@venues["places"][0].location["city"]+","+@venues["places"][0].location["state"],"Found")
   end 
end

if(@yahoo_results)
  if(@yahoo_results[0].title)
  u.directory_savings(business_location.id,"Yahoo",params[:city]+","+params[:business_location]+","+params[:country],"Found")
end
end

render :partial=>'business_info_search'
end

private 
def state_select(object, method, country, options = {}, html_options = {})
    ActionView::Helpers::InstanceTag.new(object, method, self, options.delete(:object)).to_state_select_tag(country, options, html_options)
  end

end
