class AddImageIdToLabel < ActiveRecord::Migration
  def change
    add_column :labels, :image_id, :integer
  end
end
