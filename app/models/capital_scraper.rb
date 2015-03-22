class CapitalScraper
  require 'open-uri'
  cb_url = 'http://www.capitalbikeshare.com/data/stations/bikeStations.xml'
  @page = Nokogiri::XML(open(cb_url))

  def self.all_stations
    stations = []
    @page.css('station').each do |station|
      stations << station
    end
    stations
  end

  def self.float_fields
    ['lat','long']
  end

  def self.datetime_fields
    ['lastCommWithServer','latestUpdateTime']
  end

  def self.integer_fields
    ['id','terminalName','lastCommWithServer','installDate','removalDate',
     'nbBikes','nbEmptyDocks','latestUpdateTime']
  end

  def self.cb(field)
    field = 'cb_' + field
  end

  def self.format_field(element)
    formatted_field = element.text

    formatted_field = element.text.to_f if float_fields.include?(element.name)
    formatted_field = element.text.to_i if integer_fields.include?(element.name)
    formatted_field = Time.at(element.text[0..9].to_i) if datetime_fields.include?(element.name)
    formatted_field
  end

  def self.load_station(station)
    s = Station.new()
    station.children.each do |element|
      print element.name, ', '
      print "Class = #{format_field(element).class}", ', '
      puts format_field(element)
      s[cb(element.name)] = format_field(element) unless ['nbBikes','nbEmptyDocks'].include?(element.name)
    end
    puts s.attributes
    #s.save
  end
  
  def self.first_station
    all_stations.first
  end

  def self.test
    load_station_stats(first_station)
  end

  def self.load_station_stats(station)
    ss = StationStat.new()
    ss['statusTime'] = Time.now
    ss['station_id'] = station.css('id').first.text
    ss['cb_nbBikes'] = station.css('nbBikes').first.text
    ss['cb_nbEmptyDocks'] = station.css('nbEmptyDocks').first.text
    puts ss.attributes
  end

  def self.load_all_stations
    all_stations.each do |station|
      load_station(station)
    end
    return "Finished!"
  end

end
