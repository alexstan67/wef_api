class AddCategoryToOsmPolygones < ActiveRecord::Migration[7.0]
  def change
    add_column :osm_polygones, :category, :string
  end
end
