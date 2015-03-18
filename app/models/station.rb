class Station < ActiveRecord::Base
  has_many :station_stats
  attr_accessor :cb_id, :cb_name, :cb_terminalName, :cb_lastCommWithServer,
    :cb_lat, :cb_long, :b_installed, :cb_locked, :cb_installDate,
    :cb_removalDate, :cb_temporary, :cb_public, :cb_latestUpdateTime
end
