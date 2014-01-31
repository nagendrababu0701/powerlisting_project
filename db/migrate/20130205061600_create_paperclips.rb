class CreatePaperclips < ActiveRecord::Migration
  def change
    create_table :paperclips do |t|
      t.string :uploading_file

      t.timestamps
    end
  end
end
