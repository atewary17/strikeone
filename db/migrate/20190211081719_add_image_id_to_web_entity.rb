class AddImageIdToWebEntity < ActiveRecord::Migration
  def change
    add_column :web_entities, :image_id, :integer
  end
end
