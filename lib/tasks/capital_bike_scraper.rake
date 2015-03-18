require 'open-uri'
require 'nokogiri'

cb_url = "http://www.capitalbikeshare.com/data/stations/bikeStations.xml"

def scrape_xml_page(url)
  page = Nokogiri::XML(open(url))
  return page
end

namespace :cb_scraper do
  page = scrape_xml_page(cb_url)
end
