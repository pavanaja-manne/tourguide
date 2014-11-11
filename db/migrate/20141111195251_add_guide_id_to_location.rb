class AddGuideIdToLocation < ActiveRecord::Migration
 def change
    add_column :locations, :guide_id, :integer
  end
end
