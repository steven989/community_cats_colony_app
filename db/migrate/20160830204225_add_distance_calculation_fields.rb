class AddDistanceCalculationFields < ActiveRecord::Migration
  def change
    add_column :colonies, :lat, :float
    add_column :colonies, :lng, :float
    add_column :colonies, :distance, :float
  end
end
