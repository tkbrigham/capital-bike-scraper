require 'rails_helper'

RSpec.describe CapitalParser, type: :model do
  f = File.read('fixtures/cb_large.xml')
  scrape_large = Nokogiri::XML(f)

  let(:parser_large)  { CapitalParser.new(scrape_large) }
  
  describe '#parse' do
    it 'creates new ApiStationElements for each station' do
      api_station = spy('api_station_element')
      allow(ApiStationElement).to receive(:new).and_return(api_station)

      parser_large.parse

      expect(ApiStationElement).to have_received(:new).exactly(6).times
    end
  end
end

