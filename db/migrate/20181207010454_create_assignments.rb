class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.bigint :project_employee_id, :null => false
      t.bigint :seat_id, :null => false
      t.date :assignment_date, :null => false
      t.integer :status, :limit => 4, :null => false
      t.timestamps
    end
    add_foreign_key :assignments, :seats
    add_foreign_key :assignments, :project_employees
  end
end
