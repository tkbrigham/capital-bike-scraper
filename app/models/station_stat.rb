class StationStat < ActiveRecord::Base
  belongs_to :station, primary_key: 'cb_id'
end
