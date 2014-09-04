class CreateGuides < ActiveRecord::Migration
  def change
    create_table :guides do |t|
      t.string :title
      t.string :tag_line
      t.string :city
      t.integer :stress_factor
      t.string :pacing
      t.string :category      
      t.timestamps
    end
  end
end
