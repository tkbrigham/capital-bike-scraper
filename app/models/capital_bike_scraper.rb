class CapitalBikeScraper < ActiveRecord::Base
  require 'open-uri'
  cb_url = "http://www.capitalbikeshare.com/data/stations/bikeStations.xml"

  @page = Nokogiri::XML(open(cb_url))

  def self.put_size
    # puts @page
    puts @page.css('station').size
  end

  def self.put_names
    @page.css('station').each do |station|
      puts station.css('name').text
    end
  end
 
end
