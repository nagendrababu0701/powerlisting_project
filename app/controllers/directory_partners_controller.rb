class DirectoryPartnersController < ApplicationController
  layout "common_layout"

  def index
  end

  def show
    @preffered_api = []
    @directory_partners=Directoriespartner.all
    preffered_a = User.current.directoriespartners
    unless preffered_a.blank?
      preffered_a.each{|x| @preffered_api << x.name }
     end 
     #@directory_partners=DirectoryPartner.all
  end

def new
   @directory_partner=DirectoryPartner.new
end

def create
 
end

  def edit
  end

  def update
pamas_all=params[:preffered]
user_now=User.current
checked_api=Directoriespartner.find_by_sql("SELECT * FROM directoriespartners WHERE directoriespartners.name IN ('#{pamas_all.join("','")}')") unless pamas_all.blank?
unless checked_api.blank?
    checked_api.each do |x|
       user_now.directoriespartners <<  x if user_now.directoriespartners.find_by_name(x.name).blank?
    end 
end    
un_checked_api=Directoriespartner.find_by_sql("SELECT * FROM directoriespartners WHERE directoriespartners.name NOT IN ('#{pamas_all.join("','")}')") unless pamas_all.blank?
un_checked_api = user_now.directoriespartners if pamas_all.blank?
unless un_checked_api.blank?
  un_checked_api.each do |y|
     user_now.directoriespartners.delete(y)
  end
end   
   redirect_to directory_partners_show_path
end
end