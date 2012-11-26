module UsersBusinessLocationsHelper
	def get_cities
     COUNTRY_STATE_CONFIG["states_in_india"].split(",")
  end
  def get_countries
     COUNTRY_STATE_CONFIG["countries_names"].split(",")[0,105]
  end
end
