class DirectoriespartnersUsers < ActiveRecord::Migration
   def self.up
    create_table :directoriespartners_users, :id => false do |t|
      t.integer :directoriespartner_id
      t.integer :user_id
    end  
      
  end

  def self.down
    drop_table :directoriespartners_users
  end
end
