class AddAttachmentScanToImage < ActiveRecord::Migration
   def self.up
    change_table :images do |t|
      t.attachment :scan
    end
  end

  def self.down
    drop_attached_file :images, :scan
  end
end
