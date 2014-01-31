class CreateDirectorypartners < ActiveRecord::Migration
  def change
    create_table :directorypartners do |t|
      t.string :name
      t.timestamps
    end
  end
end
