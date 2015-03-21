require 'rails_helper'

RSpec.describe CapitalScraper, type: :model do
  describe "CapitalScraper model" do
    it "format_fields" do
      expect(CapitalScraper.all_fields).to eq(["id", "name", "terminalName", "lastCommWithServer", "lat", "long", "installed", "locked", "installDate", "removalDate", "temporary", "public", "nbBikes", "nbEmptyDocks", "latestUpdateTime"])
    end
  end

end
