class AddIndexToColonyLocations < ActiveRecord::Migration
  def self.up
    add_index  :colonies, [:lat, :lng]
  end

  def self.down
    remove_index  :colonies, [:lat, :lng]
  end
end
