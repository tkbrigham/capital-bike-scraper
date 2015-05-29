class CreateStationAvailabilities < ActiveRecord::Migration
  def change
    create_table :station_availabilities do |t|
      t.belongs_to :station, index: true
      t.decimal :average_bikes
      t.decimal :average_docks
      t.integer :day_of_week
      t.integer :time_integer
    end
  end
end
