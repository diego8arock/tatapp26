class Project < ApplicationRecord
  has_many :seats
  has_many :project_employees
end
