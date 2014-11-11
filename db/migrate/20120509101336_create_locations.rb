class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.float :long
      t.float :lat
      t.string :tag
      t.string :category
      t.text :why_i_like
      t.timestamps
    end
  end
end
