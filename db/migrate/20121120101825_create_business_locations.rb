class CreateBusinessLocations < ActiveRecord::Migration
  def change
    create_table :business_locations do |t|
      t.string :business_name
      t.string :city
      t.string :state
      t.string :country
      t.string :pincode
      t.integer :user_id
      t.string :login_time
      t.string :address
      t.string :logincount

      t.timestamps
    end
  end
end
