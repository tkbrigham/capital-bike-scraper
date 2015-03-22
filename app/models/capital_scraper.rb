class CapitalScraper
  require 'open-uri'
  cb_url = 'http://www.capitalbikeshare.com/data/stations/bikeStations.xml'
  @page = Nokogiri::XML(open(cb_url))

  def self.load_all_station_stats
    all_stations.each do |station|
      load_station_stats(station)
    end
  end

  def self.load_station_stats(station)
    ss = StationStat.new()
    ss['statusTime'] = Time.now
    ss['station_id'] = station.css('id').first.text
    ss['cb_nbBikes'] = station.css('nbBikes').first.text
    ss['cb_nbEmptyDocks'] = station.css('nbEmptyDocks').first.text
    ss.save!
  end

  def self.load_new_stations
    new_stations.each do |station|
      load_station(station)
    end
  end

  def self.load_station(station)
    s = Station.new()
    station.children.each do |element|
      s[cb(element.name)] = format_field(element) unless ['nbBikes','nbEmptyDocks'].include?(element.name)
    end
    s.save!
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

  def self.format_field(element)
    formatted_field = element.text
    formatted_field = element.text.to_f if float_fields.include?(element.name)
    formatted_field = element.text.to_i if integer_fields.include?(element.name)
    formatted_field = Time.at(element.text[0..9].to_i) if datetime_fields.include?(element.name)
    formatted_field
  end

  def self.new_stations
    new_stations = []
    all_stations.each do |s|
      if new_station_ids.include?(s.css('id').first.text.to_i)
        new_stations << s
      end
    end
    new_stations
  end

  def self.new_station_ids
    new_station_ids = []
    for i in (existing_station_ids.max + 1)..cb_station_ids.max
      new_station_ids << i
    end
    new_station_ids
  end

  def self.existing_station_ids
    station_ids = []
    Station.find_each do |s|
      station_ids << s.id
    end
    station_ids
  end

  def self.cb_station_ids
    station_ids = []
    all_stations.each do |s|
      station_ids << s.css('id').first.text.to_i
    end
    station_ids
  end
  
end
