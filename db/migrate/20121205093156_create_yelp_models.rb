class CreateYelpModels < ActiveRecord::Migration
  def change
    create_table :yelp_models do |t|

      t.timestamps
    end
  end
end
