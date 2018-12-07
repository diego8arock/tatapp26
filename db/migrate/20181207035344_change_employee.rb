class ChangeEmployee < ActiveRecord::Migration[5.2]
  def change
    change_table :employees do |t|
          add_foreign_key :employees, :seats
    end
  end
end
