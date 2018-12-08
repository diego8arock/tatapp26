class Assignment < ActiveRecord::Base
  validates :assignment_date, :project_employee_id, :seat_id, :presence => true

  belongs_to :seat, :class_name => "Seat"
  belongs_to :project_employee, :class_name => "ProjectEmployee"


  ACTIVE = 1
  INACTIVE = 2
end
