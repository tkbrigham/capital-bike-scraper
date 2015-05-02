class FieldConverter
  @field_mapper = {
    # Station fields
    'cb_id' => 'id',
    'name' => 'name',
    'terminal_id' => 'terminalName',
    'last_comm_with_server' => 'lastCommWithServer',
    'latitude' => 'lat',
    'longitude' => 'long',
    'installed' => 'installed',
    'locked' => 'locked',
    'install_date' => 'installDate',
    'removal_date' => 'removalDate',
    'temporary' => 'temporary',
    'public' => 'public',
    # StationStat fields
    'station_id' => 'id',
    'cb_latest_update_time' => 'lastCommWithServer',
    'bikes_available' => 'nbBikes',
    'docks_available' => 'nbEmptyDocks',
  }

  def self.native_field(field)
    @field_mapper[field]
  end
end
