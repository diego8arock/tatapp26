class CreateProjectEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :project_employees do |t|
      t.bigint :project_id, :limit => 20, :null => false
      t.bigint :employee_id, :limit => 20, :null => false
      t.integer :status, :limit => 4
    end
    add_foreign_key :project_employees, :projects
    add_foreign_key :project_employees, :employees
  end
end
