class DirectorypartnersUsers < ActiveRecord::Migration
  def self.up
    create_table :directorypartners_users, :id => false do |t|
      t.integer :directorypartner_id
      t.integer :user_id
    end  
    add_index :directorypartners_users, :directorypartner_id
    add_index :directorypartners_users, :user_id      
  end

  def self.down
    drop_table :directorypartners_users
  end
end
