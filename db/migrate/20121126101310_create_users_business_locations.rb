class CreateUsersBusinessLocations < ActiveRecord::Migration
  def change
    create_table :users_business_locations do |t|

      t.timestamps
    end
  end
end
