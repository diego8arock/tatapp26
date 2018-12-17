class CreateZones < ActiveRecord::Migration[5.2]
  def change
    create_table :zones do |t|
      t.bigint :project_id, :limit => 20, :null => false
      t.string :coordinates, :null => false
    end
    add_foreign_key :zones, :projects
  end
end
