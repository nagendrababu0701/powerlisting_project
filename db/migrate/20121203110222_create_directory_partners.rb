class CreateDirectoryPartners < ActiveRecord::Migration
  def change
    create_table :directory_partners do |t|
      t.string :name
      t.string :description
      t.boolean :preffered

      t.timestamps
    end
  end
end
