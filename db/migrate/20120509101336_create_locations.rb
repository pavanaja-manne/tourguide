class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float :lat
      t.float :long
      t.string :name
      t.string :tag
      t.text :about
      t.integer :guide_id

      t.timestamps
    end
  end
end
