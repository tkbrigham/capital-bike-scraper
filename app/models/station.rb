class Station < ActiveRecord::Base
  has_many :station_stats

  validates :cb_id, :name, :terminal_id, :latitude, :longitude, presence: true
  validates :cb_id, uniqueness: true
end
