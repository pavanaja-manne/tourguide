class AddUserIdToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :user_id, :integer
    add_column :locations, :address, :string
  end
end
