class CreateMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :maps do |t|
      t.string :name, :null => false
      t.text :seats
      t.integer :height, :limit => 4, :null => false
      t.integer :width, :limit => 4, :null => false
      t.integer :seats_total, :limit => 4, :null => false
      t.bigint :project_id, :limit => 20, :null => false
      t.timestamps
    end
    add_foreign_key :maps, :projects
  end
end
