require 'rails_helper'

RSpec.describe CapitalScraper, type: :model do
  #VCR.use_cassette("cb_scrape") do
    let(:url) { "www.capitalbikeshare.com" }
    let(:stub) { stub_request(:any, url) }
    let(:response) { Net::HTTP.get_response(url, '/data/stations/bikeStations.xml') }
    let(:xml)  { Nokogiri::XML(response.body) }
    
    it "should return Nokogiri::XML::Document object" do
      expect(xml.class).to be(Nokogiri::XML::Document)
    end
  #end
end
