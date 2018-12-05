class Seat < ApplicationRecord

  belongs_to :project, :foreign_key => "id_project"
  belongs_to :map, :foreign_key => "id_map"
  has_many :project_employees

    ACTIVE = 1
    INACTIVE = 2
    UNAVAILABLE = 3
end
