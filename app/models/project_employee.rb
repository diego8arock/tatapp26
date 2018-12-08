class ProjectEmployee < ApplicationRecord
  belongs_to :project
  belongs_to :employee
  has_many :assignments

  ACTIVE = 1
  INACTIVE = 2
end
