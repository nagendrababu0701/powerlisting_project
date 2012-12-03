class CreateDirectoryLists < ActiveRecord::Migration
  def change
    create_table :directory_lists do |t|
      t.string :name
      t.string :description
      t.string :preffered

      t.timestamps
    end
  end
end
