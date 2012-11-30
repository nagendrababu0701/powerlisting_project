class CreateApiMasters < ActiveRecord::Migration
  def change
    create_table :api_masters do |t|
      t.string :api_name

      t.timestamps
    end
  end
end
