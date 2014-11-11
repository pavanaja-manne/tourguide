class AddLatLngToGuide < ActiveRecord::Migration
  def change
    add_column :guides, :lat, :float
    add_column :guides, :lng, :float    
  end
end
