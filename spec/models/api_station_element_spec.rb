require 'rails_helper'

RSpec.describe ApiStationElement, type: :model do
  describe "#update_data" do
    f = File.read('cb_large.xml')
    f.gsub!('&','and')
    scrape_large = Nokogiri::XML(f)
    element = scrape_large.css('station').last

    it "creates new Station model if Station doesn't exist" do
      station_spy = spy("station", update!: true)
      allow(Station).to receive(:find_or_initialize_by).and_return(station_spy)
      allow(station_spy).to receive(:update!)

      ApiStationElement.new(element).update_data

      expect(Station).to have_received(:find_or_initialize_by).with(cb_id: '6')
      expect(station_spy).to have_received(:update!).exactly(1).times
    end

    it "creates a new StationStat model" do
      station_stat_spy = spy("station_stat")
      allow(StationStat).to receive(:new).and_return(station_stat_spy)

      ApiStationElement.new(element).update_data

      expect(StationStat).to have_received(:new).exactly(1).times
      expect(station_stat_spy).to have_received(:save).exactly(1).times
    end
  end
end
