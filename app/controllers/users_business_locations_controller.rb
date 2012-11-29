require "rubygems"
 require "test/unit"
 require "net/https"
# require 'yahoo/local_search'
 class UsersBusinessLocationsController < ApplicationController
layout 'common_layout'
before_filter :check_if_login_required 
 # skip_before_filter :search_business_details
def hai

end
def previous_information_details

user=User.current

#if(user)
#@last_business_searches= BusinessLocation.where(:user_id =>user.id).last#if(business_locations)
 #@directories=Directory.find(:all, :conditions=>"business_location_id='#{business_locations.id}'")
#end#
	#@user=User.first(:conditions=>"firstname = '#{params[:user_id]}'", :include=>[{:business_locations=>[:directories]}])
#end
end

def bussiness_details_search

@user=User.current
@name=@user.firstname
@login_time=@user.last_login_on
@business_user_id=BusinessLocation.find_by_user_id(@user.id)
@last_3=BusinessLocation.find(:all, :conditions=>"user_id = '#{@user.id}'", :order => "id desc", :limit => 3) if !@user.firstname.blank?
end

def select_states
s=state_select('business_location', 'state', country= params[:country], options = {}, html_options = {})
render :text => s
end


def search_business_details

user=User.find_by_id(params[:user_id].to_i)
address=""
address=user.address1.to_s if user
@name=user.firstname
@login_time=user.last_login_on

#yls = Yahoo::LocalSearch.new('0yJmk9cUNjYUg0RWhVOG1aJmQ9WVdrOVNUZEdkMjFrTXpJbWNHbzlNVEV4TVRJd05UWXkmcz1jb25zdW1lcnNlY3JldCZ4PWI')
#@yahoo_results = yls.locate params[:business], params[:pincode], 5

phone=params[:ph_no].to_s 
city=params[:city].to_s 
business=params[:business].to_s 
state=params[:business_location].to_s 
country=params[:country].to_s 
pincode=params[:pincode].to_s 
match=phone
match=city if phone.blank?
#yelp searching conditions
if !phone.blank? && !city.blank?
e1=Net::HTTP.get(URI.parse(URI.escape("http://api.yelp.com/phone_search?phone="+phone+"&ywsid=GanonVA_293b8gzCHFgHdQ")))
search_address=JSON.parse(e1)
   if(search_address["message"]["text"]=="OK")
     if(search_address["businesses"][0]["address1"].include?(city) || search_address["businesses"][0]["city"].include?(city) )
          @response_results=search_address 
          @yelp_results=@response_results["message"]["text"]
     end
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

#End of the yelp search.



#Foursquare search condition.
foursquare=Foursquare::Base.new('2LRH0UGPXER4KLVDBCOHZUNKKWWCM5JI0B2F05IDFUEREUMD','M4EK4OH2FMKH0WNFJYDPL2GWNAF1AOCTZ4YE1XFE22OQXN0H')
@s = Geocoder.search(city+","+state+","+country+","+pincode)
@venues = foursquare.venues.search(:query => params[:business], :ll => @s[0].latitude.to_s+","+@s[0].longitude.to_s) if !@s.blank?

#End of Foursquare search condition .
#saving the search contents in to business location model.



#End of Foursquare search condition .
#saving the search contents in to business location model.

if params[:business_ids].blank?
business_location=BusinessLocation.new(:address=> params[:address], :country =>params[:country], :city => params[:city], :state=> params[:business_location], :business_name=>params[:business], :pincode => params[:pincode], :user_id => user.id, :login_time => user.last_login_on, :ph_no => phone)
business_location.save
#End of business locations savings.

#savings directories code

u=UsersBusinessLocation.new

  if(@yelp_results=="OK")
    u.directory_savings(business_location.id,@response_results["businesses"][0]["name"],@response_results["businesses"][0]["city"]+","+@response_results["businesses"][0]["state"],"Found") if(@response_results["businesses"]!=[])
      end
if(!@venues.blank?)
   u.directory_savings(business_location.id,"Foursquare",@venues["places"][0].location["city"]+","+@venues["places"][0].location["state"],"Found") if(@venues["places"]!=[])
  end

if(!@yahoo_results.blank?)
u.directory_savings(business_location.id,"Yahoo",@yahoo_results[0].address+","+@yahoo_results[0].city+","+@yahoo_results[0].state+","+@yahoo_results[0].phone,"Found") if(!@yahoo_results[0].title.blank?)
end
end
#end of directories savings.
render :partial=>'business_info_search'
end

private 
def state_select(object, method, country, options = {}, html_options = {})
    ActionView::Helpers::InstanceTag.new(object, method, self, options.delete(:object)).to_state_select_tag(country, options, html_options)
  end

end
