class AddCategoryToOsmLines < ActiveRecord::Migration[7.0]
  def change
    add_column :osm_lines, :category, :string
  end
end
