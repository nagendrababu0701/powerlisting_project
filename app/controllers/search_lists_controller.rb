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

def fix_list
a=params[:directories].split(",")
directories=Directoriespartner.find_by_sql("SELECT * FROM directoriespartners WHERE directoriespartners.name IN ('#{a.join("','")}')")
end

def select_states
s=state_select('search_list', 'state', country= params[:country], options = {}, html_options = {})
render :text => s
end


def search_business_details
user=User.find_by_id(params[:user_id].to_i)
address=""

@user_id=""
address=user.address1.to_s if user
@user_id=user.id if user

phone=params[:ph_no].to_s 
city=params[:city].to_s 
business=params[:business].to_s 
state=params[:business_location].to_s 
country=params[:country].to_s 
pincode=params[:pincode].to_s 

@directories=[]
dir = user.directoriespartners
non_user =  Directoriespartner.all
dir.each{|x| @directories << x.name } unless dir.blank? unless user.blank?
non_user.each{|x| @directories << x.name } unless non_user.blank? if user.firstname.blank?
 
 #yelp search condition.   
if @directories.include?("YELP")
  @response_results = YelpModel.yelp_method(:address=>address,:phone=>phone, :city=>city, :state=>state, :country=>country, :pincode=>pincode, :business=>business)
end

#Foursquare search condition.
if @directories.include?("FOURSQUARE")
  @venues = FoursquareModel.foursuare_method(:address=>address,:phone=>phone, :city=>city, :state=>state, :country=>country, :pincode=>pincode, :business=>business)
end

#yahoo search condition
if @directories.include?("YAHOO")
  #@yahoo_results=YahooModel.yahoo_method(:address=>address,:phone=>phone, :city=>city, :state=>state, :country=>country, :pincode=>pincode, :business=>business)
end

#saving the search contents in to business location model.
search_list=SearchList.new(:address=> address, :country =>country, :city => params[:city], :state=> params[:business_location], :business_name=>params[:business], :pin_code => params[:pincode], :user_id => params[:user_id], :ph_no => phone)
search_list.save
#End of Search list savings.

#savings directories code

call=SearchList.new

if(!@response_results.blank? && @response_results["message"]["text"]=="OK")
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
  if user.id==51
    redirect_to signin_path
  end
  @search_list=SearchList.where(:user_id=>user.id).last
end

def update_search_list
  user=User.current
  @update_list=SearchList.where(:user_id=>user.id).last 
  @update_list.update_attributes(params[:search_list])
  
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


