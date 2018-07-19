class CreateUploads < ActiveRecord::Migration[5.2]
  def change
    create_table :uploads do |t|
      t.integer :user_id
      t.string :file_name
      t.string :file_type
      t.string :path

      t.timestamps
    end
  end
end
