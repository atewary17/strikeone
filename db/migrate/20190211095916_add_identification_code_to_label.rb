class AddIdentificationCodeToLabel < ActiveRecord::Migration
  def change
    add_column :labels, :identification_code, :string
  end
end
