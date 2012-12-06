class YahooModel < ActiveRecord::Base
  # attr_accessible :title, :body
  def self.yahoo_method(options={})
yls = Yahoo::LocalSearch.new(APPID['defaults']['yahoo_id'])
yahoo_results = yls.locate options[:business], options[:pincode], 5
returns yahoo_results
end
