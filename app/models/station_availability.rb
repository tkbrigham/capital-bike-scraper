class StationAvailability < ActiveRecord::Base
  include Roundable

  belongs_to :station, primary_key: 'cb_id'

  after_initialize do |avail|
    @time = self.time
    @station = Station.find_by(cb_id: station_id)
    @stats = stats_by_station_and_time(station_id)

    self.update!
  end

  def stats_by_station_and_time(station_id)
    s = StationStat.select { |ss| ss.station_id == station_id }
    s.select! { |ss| ss.scrape_timestamp.mil_time.
                between?(@time.to_i.round_down(10),@time.to_i.round_up(10)) }
    s
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
