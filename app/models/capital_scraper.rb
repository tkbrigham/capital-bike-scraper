class CapitalScraper
  require 'open-uri'
  cb_url = 'http://www.capitalbikeshare.com/data/stations/bikeStations.xml'
  @page = Nokogiri::XML(open(cb_url))

  def self.all_fields
    fields = []
    @page.css('station').first.children.each do |child|
      fields << child.name
    end
    fields
  end

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

  def self.first_station
    @page.css('station').first
  end

  def self.test
    first_station.children.each do |child|
      puts format_field(child).class
    end
  end

  def self.test2
    find_values(first_station)
  end

  def self.find_values(station)
    station_values = []
    all_fields.each do |field|
      station.css(field).children.each do |child|
        station_values << format_field(child)
      end
    end
    station_values
  end

  def self.format_field(element)
    formatted_field = element.text
    if float_fields.include?(element.name)
      puts "FLOAT"
      formatted_field = element.text.to_f 
    end

    if integer_fields.include?(element.name)
      puts "INTEGER"
      formatted_field = element.text.to_i
    end

    if datetime_fields.include?(element.name)
      puts "TIME FIELD"
      formatted_field = Time.at(element.text[0..9].to_i) 
    end

    formatted_field
  end

  def self.load_first_station
    s = Station.new()
    ss = StationStat.new()
    first_station.children.each do |element|
      puts element.name
      puts format_field(element)
      "
      if ['nbBikes','nbEmptyDocks'].include?(value)
        ss[cb(value)] = first_station.css(value)
      else
        s[cb(value)] = first_station.css(value)
      end
      "
    end
    puts s.attributes
    puts ss.attributes
  end

end
