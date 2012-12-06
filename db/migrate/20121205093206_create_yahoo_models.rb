class CreateYahooModels < ActiveRecord::Migration
  def change
    create_table :yahoo_models do |t|

      t.timestamps
    end
  end
end
