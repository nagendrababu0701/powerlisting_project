class FoursquareModel < ActiveRecord::Base
  # attr_accessible :title, :body
  def self.foursuare_method(options={})
  		foursquare=Foursquare::Base.new(APPID['defaults']['foursquare_api'],APPID['defaults']['foursquare_secret'])
		@s = Geocoder.search(options[:city]+","+options[:state]+","+options[:country]+","+options[:pincode])
		match=options[:phone]
		match=options[:city] if options[:phone].blank?
		venues = foursquare.venues.search(:query => options[:business], :ll => @s[0].latitude.to_s+","+@s[0].longitude.to_s, :intent => :match) if @s!=[]
		return venues
  end
end
