class AddPreferanceToDirectoryPreferance < ActiveRecord::Migration
  def change
    add_column :directory_preferances, :preferance, :boolean
  end
end
