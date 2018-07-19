class AddHashToUploads < ActiveRecord::Migration[5.2]
  def change
    add_column :uploads, :uuid, :string
  end
end
