class AddGeotypeToOsmPoints < ActiveRecord::Migration[7.0]
  def change
    add_column :osm_points, :geotype, :integer
  end
end
