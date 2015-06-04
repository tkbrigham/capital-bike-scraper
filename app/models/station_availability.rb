class StationAvailability < ActiveRecord::Base
  belongs_to :station, primary_key: 'cb_id'

  after_initialize do |avail|
    self.time = self.time[0..3].to_s
    @min_time = mil_time_plus_min(self.time[0..3], -9)
    @max_time = mil_time_plus_min(self.time[0..3], 11)
    @station = Station.find_by(cb_id: station_id)
    @stats = stats_by_station_and_time(station_id)

    self.update!
  end

  def stats_by_station_and_time(station_id)
    s = StationStat.where('station_id = ?', station_id)
    psql_chars = "to_char(scrape_timestamp, 'HH24MI')"
    s.where("#{psql_chars} > ? AND #{psql_chars} < ?", @min_time, @max_time)
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
    #puts mil_time.class
    #puts mil_time[0..1].class
    hour = mil_time[0..1]
    min = mil_time[2..3]
    time = Time.new(1988,1,18,hour,min) + minutes.minutes
    time.strftime("%H%M")
  end
end
