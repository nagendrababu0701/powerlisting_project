class AddLogincountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :logincount, :string
  end
end
