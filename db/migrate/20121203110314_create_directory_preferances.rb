class CreateDirectoryPreferances < ActiveRecord::Migration
  def change
    create_table :directory_preferances do |t|
      t.integer :user_id
      t.integer :directory_partner_id
      t.date :date

      t.timestamps
    end
  end
end
