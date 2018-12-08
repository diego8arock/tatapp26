class Project < ApplicationRecord
  has_many :seats
  has_many :project_employees
  has_many :employees, :through => :project_employees
  
	ACTIVE = 1
	INACTIVE = 2
end
