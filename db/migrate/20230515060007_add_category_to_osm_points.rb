class AddCategoryToOsmPoints < ActiveRecord::Migration[7.0]
  def change
    add_column :osm_points, :category, :string
  end
end
