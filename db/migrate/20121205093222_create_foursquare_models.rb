class CreateFoursquareModels < ActiveRecord::Migration
  def change
    create_table :foursquare_models do |t|

      t.timestamps
    end
  end
end
