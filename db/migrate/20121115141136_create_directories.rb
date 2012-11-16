class CreateDirectories < ActiveRecord::Migration
  def change
    create_table :directories do |t|
      t.integer :business_location_id
      t.string :business_lising_information
      t.string :categories
      t.string :web_site
      t.string :description
      t.string :photos
      t.string :special_offer
      t.string :status

      t.timestamps
    end
  end
end
