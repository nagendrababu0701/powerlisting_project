class CreateSearchLists < ActiveRecord::Migration
  def change
    create_table :search_lists do |t|
      t.integer :user_id
      t.string :business_name
      t.string :city
      t.string :state
      t.string :country
      t.string :pin_code
      t.string :ph_no

      t.timestamps
    end
  end
end
