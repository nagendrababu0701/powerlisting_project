class DirectoryPartnersController < ApplicationController
  layout "common_layout"
  def index
  end

  def show
    @directory_partners=DirectoryPartner.all
  end

  def create
  end

  def edit
  end

  def update
    debugger
    directory=DirectoryPartner.find_by_id(params[:directory].to_i)
    directory_preferance=DirectoryPreferance.find_by_directory_partner_id_and_user_id(directory.id,User.current.id)   if directory
    if params[:preffered].nil?
      directory.update_attributes(:preffered=>0) 
      directory_preferance.update_attributes(:preferance=>0) if directory_preferance
    #elsif  !params[:preffered].nil? && !directory.preffered.eql?(0) 
    #  directory.update_attributes(:preffered=>1) 
     # directory_preferance.update_attributes(:preferance=>1) if directory_preferance
    else
      directory.update_attributes(:preffered=>1)    
      DirectoryPreferance.create(:user_id=>User.current.id,:directory_partner_id=>directory.id,:preferance =>true)
     end 
       
    flash[:notice] = "Your Directory listing search changed successfully. Thank you!" 
    redirect_to directory_partners_show_url
  end

  def new
  end
end
