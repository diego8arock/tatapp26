class Employee < ApplicationRecord
  validates :number, presence: true, uniqueness: true
  belongs_to :seat, :foreign_key => "id_seat"
  has_many :project_employees
  has_many :projects, :through => :project_employees

  MOBILE = 1
  FIXED = 2

  ACTIVE = 1
  INACTIVE = 2
end
