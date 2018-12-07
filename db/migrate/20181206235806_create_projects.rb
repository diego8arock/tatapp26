class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name, :null => false
      t.integer :status, :limit => 4, :null => false, :default => 1
      t.string :tag, :limit => 3, :null => false
      t.timestamps
    end
  end
end
