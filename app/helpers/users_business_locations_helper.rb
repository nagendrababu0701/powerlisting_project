module UsersBusinessLocationsHelper


def results_app_params(bus_name,address,category,web_site,description,photos,offer,total_revenue,fount_or_not,i)
  data=""
  if((i%2)==0) 
    id='color1'
  else
    id='color2'
  end 
           data << "<tr class=#{id}>"
               data << "<td>#{bus_name}</td>"

              
            if(!address.blank?) 
               data << "<td>#{address}</td>"
            else
              data << "<td> The Address Was Not match</td>"
             end

             if(!category.blank?) 
               data << "<td><image src='/images/yelp_buttons/icon_tick.png'> </td>"
            else
              data << "<td><image src='/images/yelp_buttons/icon_close.png'> </td>"
             end

             if(!web_site.blank?) 
               data << "<td><image src='/images/yelp_buttons/icon_tick.png'> </td>"
            else
              data << "<td><image src='/images/yelp_buttons/icon_close.png'> </td>"
             end

             if(!description.blank?) 
               data << "<td><image src='/images/yelp_buttons/icon_tick.png'> </td>"
            else
              data << "<td><image src='/images/yelp_buttons/icon_close.png'> </td>"
             end

             if(!photos.blank?) 
               data << "<td><image src='/images/yelp_buttons/icon_tick.png'> </td>"
            else
              data << "<td><image src='/images/yelp_buttons/icon_close.png'> </td>"
             end

             if(!offer.blank?) 
               data << "<td><image src='/images/yelp_buttons/icon_tick.png'> </td>"
            else
              data << "<td><image src='/images/yelp_buttons/icon_close.png'> </td>"
             end

             if(!total_revenue.blank?) 
               data << "<td>#{total_revenue}</td>"
            else
              data << "<td>0</td>"
             end

             if(!category.blank?) 
               data << "<td class='status_bg'>Listed</td>"
            else
              data << "<td class='status_bg'>Not Listed</td> "

             end
             data <<  "</tr>"

  data.html_safe

end


	def get_cities
     COUNTRY_STATE_CONFIG["states_in_india"].split(",")
  end
  def get_countries
     COUNTRY_STATE_CONFIG["countries_names"].split(",")[0,105]
  end

end
