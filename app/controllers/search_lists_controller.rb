 require "rubygems"
 require "test/unit"
 require "net/https"
# require 'yahoo/local_search'
class SearchListsController < ApplicationController
layout 'common_layout'
#before_filter :find_current_user
skip_after_filter :search_business_details

def scan_page
@user = User.current
@user_id=""
@last_3=""
@user_id = @user.id if @user
@last_3 = BusinessLocation.find(:all, :conditions=>"user_id = '#{@user.id}'", :order => "id desc", :limit => 3) if !@user.firstname.blank?
end

def select_states
s=state_select('search_list', 'state', country= params[:country], options = {}, html_options = {})
render :text => s
end


def search_business_details
 # debugger
@user=User.find(User.current)#User.find_by_id(params[:user_id].to_i)
address=""
user_id=params[:user_id]
address=@user.address1.to_s if @user

#yls = Yahoo::LocalSearch.new(APPID['defaults']['yahoo_id'])
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
e1=Net::HTTP.get(URI.parse(URI.escape("http://api.yelp.com/phone_search?phone="+phone+"&ywsid="+APPID['defaults']['yelp'])))
debugger
search_address=JSON.parse(e1)
   if(search_address["message"]["text"]=="OK")
     if(search_address["businesses"][0]["address1"].include?(city) || search_address["businesses"][0]["city"].include?(city) )
          @response_results=search_address 
          @yelp_results=@response_results["message"]["text"]
     end
   end
elsif !phone.blank?
e = Net::HTTP.get(URI.parse(URI.escape("http://api.yelp.com/phone_search?phone="+phone+"&ywsid="+APPID['defaults']['yelp'])))
@response_results=JSON.parse(e)
@yelp_results=@response_results["message"]["text"]
elsif !city.blank?
e = Net::HTTP.get(URI.parse(URI.escape("http://api.yelp.com/business_review_search?term="+business+"&location="+address+","+city+","+country+","+pincode+"&ywsid="+APPID['defaults']['yelp'])))
@response_results=JSON.parse(e)
@yelp_results=@response_results["message"]["text"]
end

#End of the yelp search.


#Foursquare search condition.
foursquare=Foursquare::Base.new(APPID['defaults']['foursquare_api'],APPID['defaults']['foursquare_secret'])
@s = Geocoder.search(city+","+state+","+country+","+pincode)
@venues = foursquare.venues.search(:query => params[:business], :ll => @s[0].latitude.to_s+","+@s[0].longitude.to_s, :intent => :match) if @s!=[]

#End of Foursquare search condition .
#saving the search contents in to business location model.

search_list=SearchList.new(:address=> address, :country =>country, :city => params[:city], :state=> params[:business_location], :business_name=>params[:business], :pin_code => params[:pincode], :user_id => user_id, :ph_no => phone)
search_list.save
#End of Search list savings.

#savings directories code

call=SearchList.new

if(@yelp_results=="OK")
  call.directory_savings(:search_id=>search_list.id,:directory_name=>"yelp") if(@response_results["businesses"]!=[])
end
if(!@venues.blank?)
  call.directory_savings(:search_id=>search_list.id,:directory_name=>"foursquare") if(@venues["places"]!=[])
end
if(!@yahoo_results.blank?)
  call.directory_savings(:search_id=>search_list.id,:directory_name=>"yahoo") if(!@yahoo_results[0].title.blank?)
end

#end of directories savings.
render :partial=>'business_info_search'
end
def edit_search_list
  
  user=User.current
  
  @search_list=SearchList.where(:user_id=>user.id).last
end

def update_search_list
  
  user=User.current
  @update_list=SearchList.where(:user_id=>user.id).last 
  @update_list.update_attributes(:city=>params[:search_list][:city],:state=>params[:search_list][:state],:country=>params[:search_list][:country],:pin_code=>params[:search_list][:pin_code],:ph_no=>params[:search_list][:ph_no],:updated_at =>Time.now)
  Issue.create(:user_id=>user.id,:subject=>params[:search_list][:business_name],:project_id=>7,:created_on=>Time.now,:updated_on=>Time.now,:start_date =>Date.today)
  issue_id=Issue.where(:user_id=>user.id).id

  #3.times { FixedResult.create(:user_id =>user.id,:directory_partner_id=>"#{d}",:issue_id=>issue_id,:status =>"New")}
  
  redirect_to scan_page_search_lists_path
  #Tracker.create(:name=>user.firstname,:user_id=>user.id)
  #tracker=Tracker.find_by_id(user.id)
end  

private 
def state_select(object, method, country, options = {}, html_options = {})
    ActionView::Helpers::InstanceTag.new(object, method, self, options.delete(:object)).to_state_select_tag(country, options, html_options)
end

end


