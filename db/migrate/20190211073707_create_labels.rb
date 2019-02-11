class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.string :description
      t.decimal :score

      t.timestamps null: false
    end
  end
end
