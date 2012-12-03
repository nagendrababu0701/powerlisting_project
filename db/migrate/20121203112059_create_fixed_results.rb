class CreateFixedResults < ActiveRecord::Migration
  def change
    create_table :fixed_results do |t|
      t.integer :directory_partner_id
      t.integer :user_id
      t.integer :issue_id
      t.string :status

      t.timestamps
    end
  end
end
