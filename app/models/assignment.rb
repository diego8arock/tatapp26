class Assignment < ActiveRecord::Base

  attr_accessor :id_project_employee, :id_seat, :assignment_date

  validates :assignment_date, :id_project_employee, :id_seat, :presence => true

  belongs_to :seat, :foreign_key => "id_seat"
  belongs_to :project_employee, :class_name => "ProjectEmployee", :foreign_key => "id_project_employee"


  ACTIVE = 1
  INACTIVE = 2
end
