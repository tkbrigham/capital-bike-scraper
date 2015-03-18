class StationStat < ActiveRecord::Base
  belongs_to :station
  attr_accessor :station_id, :statusTime, :cb_nbBikes, :cb_nbEmptyDocks
end
