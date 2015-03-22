require 'open-uri'
require 'nokogiri'

def scrape_xml_page(url)
  page = Nokogiri::XML(open(url))
  return page
end

namespace :jobs do
  desc "Prints all station data"
  task :cb_scrape => :environment do
    CapitalScraper.load_all_stations
  end
end
