class DirectoryPartnersUsers < ActiveRecord::Migration
 def self.up
    create_table :directory_partners_users, :id => false do |t|
      t.integer :directory_partner_id
      t.integer :user_id
    end  
    add_index :directory_partners_users, :directory_partner_id
    add_index :directory_partners_users, :user_id      
  end

  def self.down
    drop_table :directory_partners_users
  end
end
