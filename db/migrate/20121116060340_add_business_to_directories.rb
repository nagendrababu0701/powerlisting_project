class AddBusinessToDirectories < ActiveRecord::Migration
  def change
    add_column :directories, :business, :string
  end
end
