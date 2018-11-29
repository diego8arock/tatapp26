class CreateMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :maps do |t|
      t.string :name
      t.text :seats
      t.integer :height
      t.integer :width
      t.integer :seats_total

      t.timestamps
    end
  end
end
