class Employee < ApplicationRecord
  belongs_to :seat, optional: true
  has_many :project_employees
  has_many :projects, :through => :project_employees

  MOBILE = 1
  FIXED = 2

  ACTIVE = 1
  INACTIVE = 2
end
