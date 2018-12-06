class ProjectEmployee < ApplicationRecord
  belongs_to :project, :foreign_key => "id_project"
  belongs_to :employee, :foreign_key => "id_employee"
  has_many :assignments

  ACTIVE = 1
  INACTIVE = 2
end
