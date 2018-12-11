class Assignment < ActiveRecord::Base
  validates :assignment_date, :project_id, :employee_id, :seat_id, :presence => true

  belongs_to :seat, :class_name => "Seat"
  belongs_to :project, :class_name => "Project"
  belongs_to :employee, :class_name => "Employee"



  ACTIVE = 1
  INACTIVE = 2
end
