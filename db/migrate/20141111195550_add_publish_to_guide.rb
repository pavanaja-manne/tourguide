class AddPublishToGuide < ActiveRecord::Migration
  def change
    add_column :guides, :publish, :boolean
  end
end
