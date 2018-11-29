class ProjectEmployee < ApplicationRecord
  belongs_to :project, :foreign_key => "id_project"
  has_many :assignments

  ACTIVE = 1
  INACTIVE = 2
end
