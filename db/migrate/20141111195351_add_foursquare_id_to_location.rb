class AddFoursquareIdToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :foursquare_id, :string
    add_column :locations, :foursquare_image_url, :string
  end
end
