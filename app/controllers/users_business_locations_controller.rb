require "rubygems"
 require "test/unit"
 require "net/https"
 #require 'yahoo/local_search'

 class UsersBusinessLocationsController < ApplicationController
layout 'common_layout'
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
@name=user.firstname
@login_time=user.last_login_on

=begin
		client = Yelp::Client.new
    request = Yelp::Phone::Request::Number.new(
          :phone_number =>  params[:ph_no],
          :yws_id => 'GanonVA_293b8gzCHFgHdQ')
      response = client.search(request)
    @yelp_results=""
=end
    

#yls = Yahoo::LocalSearch.new('0yJmk9cUNjYUg0RWhVOG1aJmQ9WVdrOVNUZEdkMjFrTXpJbWNHbzlNVEV4TVRJd05UWXkmcz1jb25zdW1lcnNlY3JldCZ4PWI')
#@yahoo_results = yls.locate params[:business], params[:pincode], 5
consumer_key = 'EqkWF9LFP9HgsDXAML9BgA'
consumer_secret = 'zOEDsuF5SuGNEQQPSuv-lkLyHgo'
token = 'T4IKO-ihOsaytRN6oRrQHZFOrfjFFIAc'
token_secret = 'q8PPnDD5sssimvQ486tJsq6M0TY'

api_host = 'api.yelp.com'

consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
access_token = OAuth::AccessToken.new(consumer, token, token_secret)
path = "/v2/search?term=restaurants&location=new%20york"

 access_token.get(path).body
foursquare=Foursquare::Base.new('2LRH0UGPXER4KLVDBCOHZUNKKWWCM5JI0B2F05IDFUEREUMD','M4EK4OH2FMKH0WNFJYDPL2GWNAF1AOCTZ4YE1XFE22OQXN0H')
@venues = foursquare.venues.search(:query => params[:business], :ll => "000,00", :near => params[:city])

     business_location=BusinessLocation.new(:address=> params[:address], :city => params[:city], :state=> params[:state], :ph_no => params[:ph_no], :business_name=>params[:business], :pincode => params[:pincode], :user_id => user.id, :login_time => user.last_login_on)
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
   directories1.business_lising_information=response["businesses"][i]["city"]+","+response["businesses"][i]["city"]
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

render :partial=>'business_info_search'
end

private 
def state_select(object, method, country, options = {}, html_options = {})
    ActionView::Helpers::InstanceTag.new(object, method, self, options.delete(:object)).to_state_select_tag(country, options, html_options)
  end
end
