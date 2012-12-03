class CreateSearchResults < ActiveRecord::Migration
  def change
    create_table :search_results do |t|
      t.integer :search_list_id
      t.integer :directory_partner_id

      t.timestamps
    end
  end
end
