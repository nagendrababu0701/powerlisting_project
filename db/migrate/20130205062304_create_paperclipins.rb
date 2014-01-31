class CreatePaperclipins < ActiveRecord::Migration
  def change
    create_table :paperclipins do |t|
      t.string :upload_file_file_name
      t.string :upload_file_content_type
      t.integer :upload_file_file_size
      t.datetime :upload_file_updated_at

      t.timestamps
    end
  end
end
