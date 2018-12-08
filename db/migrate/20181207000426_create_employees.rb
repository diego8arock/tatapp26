class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :name, :null => false
      t.string :number, :limit => 30, :null => false
      t.date :admission_date, :null => false
      t.date :birth_date, :null => false
      t.integer :status, :limit => 4, :null => false, :default => 1
      t.integer :assignment_type, :limit => 4, :null => false, :default => 1, :coment => 'Fijo:1 o movil:2'
      t.bigint :seat_id, :null => true
      t.timestamps
    end
    add_index(:employees, :number, unique: true)
  end
end
