class AddAddressToBusinessLocations < ActiveRecord::Migration
  def change
    add_column :business_locations, :logincount, :string
  end
end
