class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :location, :string
    add_column :users, :biography, :text
    add_column :users, :website, :string
    add_column :users, :follow, :boolean
    add_column :users, :comment, :boolean   
  end
end
