class Route < ActiveRecord::Base
  has_many :route_stations
  has_many :stations, through: :route_stations

  require 'open-uri'

  def self.getDistances(userlocation)
    @stations = Station.all
    @mapped_stations = []
    @stations.map do |station|
      @station_location = Geokit::LatLng.new(station.latitude,station.longitude)
      @distance_to = userlocation.distance_to(@station_location)
      @mapped_stations << Hash["station",station, "distance", @distance_to]
    end
    @final = @mapped_stations.sort_by { |x| x["distance"] }
    return @final.slice(0,5)
  end

  def self.txt_read
    @doc = Nokogiri::XML(open('http://web.mta.info/status/serviceStatus.txt'))
  end

  def self.doc_parse(file)
    current_status = []
    (0..9).each do |i|
      current_status << [file.xpath("//name")[i].children.text() => {
      "status" => file.xpath('//status')[i].children.text(),
      "notes" => note_cleaner(file.xpath('//text')[i].children.text())
        }]
    end
    return current_status
  end

  def self.note_cleaner(path)
    path.gsub(/<\/?[^>]+>/, '').gsub("\n", '').gsub("&nbsp;", '').gsub("&#149;", '')
    .gsub("                    Planned Work                                      ", '')
    .gsub("                                                  Planned Work                                      ", ' ')
    .gsub("                              ", '')
    .gsub("                ", '')
  end

  def self.delayed(stations)
    html = [" "]
    routes = stations.routes.pluck(:route_short_name).partition{|x| x.is_a? String}.map(&:sort).flatten
    routes.each do |station|
      if Route.find_by(route_short_name: station).service_status != "GOOD SERVICE"
        html << "<span class='glyphicon glyphicon-warning-sign' aria-hidden='true'></span>"
        return html.join.html_safe
      end
    end
    return html.join.html_safe
  end

  def self.display_delays(stations)
    html = ["<span style='padding-left:20px'>"]
    routes = stations.routes.pluck(:route_short_name).partition{|x| x.is_a? String}.map(&:sort).flatten
    routes.each do |station|
      status = Route.find_by(route_short_name: station).service_status
      if status != "GOOD SERVICE"
          html<< "<span class='mta-bullet mta-#{station.downcase}'>#{station}</span>: #{status} "
      end
    end
    if html.length == 1
      return ""
    else
      return html.join.html_safe
    end
  end




  def self.update_status
    Route.txt_read
    @current_status = Route.doc_parse(@doc)

    @current_status.each do |route|
      if route[0].keys[0] == "123"
        Route.where(route_short_name: "1").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})
        Route.where(route_short_name: "2").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})
        Route.where(route_short_name: "3").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})

      elsif route[0].keys[0] == "456"
        Route.where(route_short_name: "4").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})
        Route.where(route_short_name: "5").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})
        Route.where(route_short_name: "5X").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})
        Route.where(route_short_name: "6").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})
        Route.where(route_short_name: "6X").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})


      elsif route[0].keys[0] == "7"
        Route.where(route_short_name: "7").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})
        Route.where(route_short_name: "7X").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})

      elsif route[0].keys[0] == "ACE"
        Route.where(route_short_name: "A").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})
        Route.where(route_short_name: "C").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})
        Route.where(route_short_name: "E").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})

      elsif route[0].keys[0] == "BDFM"
        Route.where(route_short_name: "B").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})
        Route.where(route_short_name: "D").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})
        Route.where(route_short_name: "F").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})
        Route.where(route_short_name: "M").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})

      elsif route[0].keys[0] == "G"
        Route.where(route_short_name: "G").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})

      elsif route[0].keys[0] == "JZ"
        Route.where(route_short_name: "J").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})
        Route.where(route_short_name: "Z").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})

      elsif route[0].keys[0] == "L"
        Route.where(route_short_name: "L").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})

      elsif route[0].keys[0] == "NQR"
        Route.where(route_short_name: "N").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})
        Route.where(route_short_name: "Q").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})
        Route.where(route_short_name: "R").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})

      elsif route[0].keys[0] == "S"
        Route.where(route_short_name: "S").first.update_attributes({:service_status => route[0].values[0].values[0], :service_status_note => route[0].values[0].values[1]})
      else
        puts "Error"
      end
    end
  end
end

