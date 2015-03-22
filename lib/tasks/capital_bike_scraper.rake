require 'open-uri'
require 'nokogiri'

def scrape_xml_page(url)
  page = Nokogiri::XML(open(url))
  return page
end

namespace :jobs do
  desc "Adds new Stations and adds all StationStats"
  task :cb_scrape => :environment do
    CapitalScraper.load_new_stations
    CapitalScraper.load_all_station_stats
  end
end
