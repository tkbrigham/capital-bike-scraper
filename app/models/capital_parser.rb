class CapitalParser
  def initialize(scrape)
    @scrape = scrape
  end

  def parse
    @scrape.css('station').each do |station_element|
      api_station_element = ApiStationElement.new(station_element)
      api_station_element.update_data
    end
  end
end
