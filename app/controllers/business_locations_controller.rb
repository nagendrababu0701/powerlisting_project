class BusinessLocationsController < ApplicationController
require "geocoder"
  def index
   #default venue is the "Tour Eiffel"
   foursquare=Foursquare::Base.new('2LRH0UGPXER4KLVDBCOHZUNKKWWCM5JI0B2F05IDFUEREUMD','M4EK4OH2FMKH0WNFJYDPL2GWNAF1AOCTZ4YE1XFE22OQXN0H')
     params[:name]="Reliance" || "Heritage"

      @venues = foursquare.venues.search(:query => "Reliance", :ll => "48.857,2.349")
#
   @venue_id = "185194" 
    @venue = foursquare.venues.find(@venue_id)
#params[:city]="Newyork"
#params[:business]="Infosis"
#@s = Geocoder.search(params[:city],params[:business])
#render :json => @s[0].formatted_address.to_json
  end


  def show

  end

  def new
  end

  def edit
  end

  def create
  end

  def delete
  end

  def update
  end

end
