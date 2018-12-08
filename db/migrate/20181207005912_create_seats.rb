class CreateSeats < ActiveRecord::Migration[5.2]
  def change
    create_table :seats do |t|
      t.bigint :project_id, :limit => 20, :null => false
      t.string :code, :limit => 10, :null => false
      t.integer :status, :null => false, :default => 1
      t.date :assignment_date
      t.bigint :map_id, :limit => 20, :null => false
      t.string :html_id, :null => false
      t.timestamps
    end
    add_foreign_key :seats, :projects
    add_foreign_key :seats, :maps
  end
end
