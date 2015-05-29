class StationAvailability < ActiveRecord::Base
  belongs_to :station, primary_key: 'cb_id'

  def after_intialize
    puts "INITIALIZED"
  end

  def update!
    self.bikes = calculate('bikes_available')
    self.docks = calculate('docks_available')
  end

  def calculate(field)
    stats = StationStat.select('station_id',field).select { |s| s.station_id == self.station_id }

    sum = 0
    stats.each do |s|
      sum += s.send(field)
    end

    avg = (sum / stats.count.to_f)
    "%.2f" % avg
  end
end
