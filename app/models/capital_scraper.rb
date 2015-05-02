class CapitalScraper
  require 'open-uri'

  def go
    cb_url = 'http://www.capitalbikeshare.com/data/stations/bikeStations.xml'
    f = File.read(open(cb_url))
    f.gsub!('&amp;','and')
    page = Nokogiri::XML(f)
    return page
  end
end
