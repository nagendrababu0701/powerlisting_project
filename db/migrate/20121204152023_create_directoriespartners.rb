class CreateDirectoriespartners < ActiveRecord::Migration
  def change
    create_table :directoriespartners do |t|
      t.string :name

      t.timestamps
    end
  end
end
