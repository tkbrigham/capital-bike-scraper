desc "Scrape Capital Bikeshare website for station data"
task :scrape => :environment do
  s = CapitalScraper.new.go
  c = CapitalParser.new(s)
  c.parse
end
