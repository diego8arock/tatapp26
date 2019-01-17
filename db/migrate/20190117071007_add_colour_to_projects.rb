class AddColourToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :colour, :string, :limit => 20
  end
end
