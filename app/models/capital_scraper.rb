class CapitalScraper < ActiveRecord::Base
  require 'open-uri'
  cb_url = "http://www.capitalbikeshare.com/data/stations/bikeStations.xml"
  @page = Nokogiri::XML(open(cb_url))

  def self.all_fields
    fields = []
    @page.css('station').first.children.each do |child|
      fields << child.name
    end
    fields
  end

  def self.cb(field)
    field = 'cb_' + field
  end

  def self.first_station
    @page.css('station').first
  end

  def self.load_first_station
    s = Station.new()
    ss = StationStat.new()
    all_fields.each do |field|
      if ['cb_nbBikes','cb_nbEmptyDocks'].include?(cb(field))
        ss[cb(field)] = first_station.css(field).text
      else
        s[cb(field)] = first_station.css(field).text
      end
    end
    puts s.attributes
    puts ss.attributes
  end

end
