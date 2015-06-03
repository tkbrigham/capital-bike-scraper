class StationAvailability < ActiveRecord::Base
  #include Roundable

  belongs_to :station, primary_key: 'cb_id'

  after_initialize do |avail|
    @time_integer = self.time
    @station = Station.find_by(cb_id: station_id)
    @stats = stats_by_station_and_time(station_id)

    self.update!
  end

  def stats_by_station_and_time(station_id)
    s = StationStat.where('station_id = ?', station_id)
    query = "to_char(scrape_timestamp, 'HH24MI') BETWEEN ? AND ?"
    stats = s.where(query, (@time_integer - 9).to_s,
                    (@time_integer + 11).to_s)
    stats
  end

  def update!
    self.average_bikes = calculate_avg('bikes_available')
    self.average_docks = calculate_avg('docks_available')
  end

  def calculate_avg(field)
    sum = 0
    @stats.each { |s| sum += s.send(field) }
    
    avg = (sum / @stats.count.to_f)
    "%.2f" % avg
  end
end
