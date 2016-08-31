class AddDetailsOnFindingColony < ActiveRecord::Migration
  def change
    add_column :colonies, :how_to_find_colony_at_address, :text
  end
end
