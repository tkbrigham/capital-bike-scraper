class AddLatestUpdateTimeToStation < ActiveRecord::Migration
  def change
    add_column :stations, :cb_latestUpdateTime, :datetime
  end
end
