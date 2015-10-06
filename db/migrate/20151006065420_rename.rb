class Rename < ActiveRecord::Migration
  def change
    rename_column :users, :location, :token
  end
end
