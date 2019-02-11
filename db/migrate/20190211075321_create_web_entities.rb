class CreateWebEntities < ActiveRecord::Migration
  def change
    create_table :web_entities do |t|
      t.string :description
      t.decimal :score

      t.timestamps null: false
    end
  end
end
