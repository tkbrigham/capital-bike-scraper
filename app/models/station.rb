class Station < ActiveRecord::Base
  self.primary_key = 'cb_id'
  has_many :station_stats
  has_many :station_availabilities

  validates :cb_id, :name, :terminal_id, :latitude, :longitude, presence: true
  validates :cb_id, uniqueness: true
end
