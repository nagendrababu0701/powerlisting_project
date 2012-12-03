module UsersBusinessLocationsHelper

def results_app_params(options={})
r=options[:i]-1

data=""
  if((options[:i]%2)==0) 
    id='color2'
  else
    id='color1'
  end 
           data << "<tr class=#{id}>"
                 data << "<td><image src='/images/directory_icons/#{options[:image_url]}' height='50px'> #{options[:bus_name]}</td>"
            if(!options[:address].blank?) 
               data << "<td>#{options[:address]}</td>"
            else
              data << "<td> The Address Was Not match</td>"
             end

             if(!options[:category].blank?) 
               data << "<td><image src='/images/directory_icons/icon_tick.png'></td>"
            else
              data << "<td><image src='/images/directory_icons/icon_close.png'> </td>"
             end

             if(!options[:web_site].blank?) 
               data << "<td><image src='/images/directory_icons/icon_tick.png'> </td>"
            else
              data << "<td><image src='/images/directory_icons/icon_close.png'> </td>"
             end

             if(!options[:description].blank?) 
               data << "<td><image src='/images/directory_icons/icon_tick.png'> </td>"
            else
              data << "<td><image src='/images/directory_icons/icon_close.png'> </td>"
             end

             if(!options[:photos].blank?) 
               data << "<td><image src='/images/directory_icons/icon_tick.png'> </td>"
            else
              data << "<td><image src='/images/directory_icons/icon_close.png'> </td>"
             end

             if(!options[:offer].blank?) 
               data << "<td><image src='/images/directory_icons/icon_tick.png'> </td>"
            else
              data << "<td><image src='/images/directory_icons/icon_close.png'> </td>"
             end

             if(!options[:total_revenue].blank?) 
               data << "<td>#{options[:total_revenue]}</td>"
            else
              data << "<td>0</td>"
             end

             if(!options[:category].blank?) 
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
