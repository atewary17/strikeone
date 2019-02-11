class AddIdentificationCodeToWebEntity < ActiveRecord::Migration
  def change
    add_column :web_entities, :identification_code, :string
  end
end
