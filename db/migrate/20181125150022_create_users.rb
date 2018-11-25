class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :employee_number
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :employee_number, unique: true
  end
end
