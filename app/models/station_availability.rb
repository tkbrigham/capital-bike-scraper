class StationAvailability < ActiveRecord::Base
  belongs_to :station, primary_key: 'cb_id'

  after_initialize do |avail|
    @time_string = self.time
    @station = Station.find_by(cb_id: station_id)
    @stats = stats_by_station_and_time(station_id)

    self.update!
  end

  def stats_by_station_and_time(station_id)
    s = StationStat.where('station_id = ?', station_id)
    query = "to_char(scrape_timestamp, 'HH24MI') BETWEEN ? AND ?"
    s.where(query, mil_time_plus_min(@time_string, -9),
                    mil_time_plus_min(@time_string, 11))
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

  def mil_time_plus_min(mil_time, minutes)
    hour = mil_time[0..1]
    min = mil_time[2..3]
    time = Time.new(1988,1,18,hour,min) + minutes.minutes
    time.strftime("%H%M")
  end
end
