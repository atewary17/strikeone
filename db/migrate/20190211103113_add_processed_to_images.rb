class AddProcessedToImages < ActiveRecord::Migration
  def change
    add_column :images, :processed, :boolean
  end
end
