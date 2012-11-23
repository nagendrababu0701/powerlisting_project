class AddPhnoToBusinessLocations < ActiveRecord::Migration
  def change
    add_column :business_locations, :ph_no, :string
  end
end
