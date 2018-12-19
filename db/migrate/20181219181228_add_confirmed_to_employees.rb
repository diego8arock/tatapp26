class AddConfirmedToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :confirmed, :integer, :limit => 4, default: 0, null: false
  end
end
