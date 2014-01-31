class YelpModel < ActiveRecord::Base
  # attr_accessible :title, :body

#yelp searching conditions
def self.yelp_method(options={})
if !options[:phone].blank? && !options[:city].blank?
e1=Net::HTTP.get(URI.parse(URI.escape("http://api.yelp.com/phone_search?phone="+options[:phone]+"&ywsid="+APPID['defaults']['yelp'])))
search_address=JSON.parse(e1)
   if(search_address["message"]["text"]=="OK")
     if(search_address["businesses"][0]["address1"].include?(options[:city]) || search_address["businesses"][0]["city"].include?(options[:city]) )
          response_results=search_address 
         
     end
   end
elsif !options[:phone].blank?
e = Net::HTTP.get(URI.parse(URI.escape("http://api.yelp.com/phone_search?phone="+options[:phone]+"&ywsid="+APPID['defaults']['yelp'])))
response_results=JSON.parse(e)
elsif !options[:city].blank?
e = Net::HTTP.get(URI.parse(URI.escape("http://api.yelp.com/business_review_search?term="+options[:business]+"&location="+options[:address]+","+options[:city]+","+options[:country]+","+options[:pincode]+"&ywsid="+APPID['defaults']['yelp'])))
response_results=JSON.parse(e)
end

 return response_results
end
#End of the yelp search.


end
