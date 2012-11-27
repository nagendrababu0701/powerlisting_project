module Appkey
def app_key_urls(p,s,ph,c,pin)
Geocoder.search(p,s)

Yelp::Client.new
        	Yelp::Review::Request::Location.new(
                :city => p,
	        :business =>s,
		:ph_no => ph,
		:country => c,
		:pincode => pin,
		:ywsid => 'GanonVA_293b8gzCHFgHdQ'
                )
end
end

