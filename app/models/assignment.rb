class Assignment < ActiveRecord::Base
  validates :assignment_date, :project_id, :employee_id, :seat_id, :presence => true

  belongs_to :seat, :class_name => "Seat"
  belongs_to :project, :class_name => "Project"
  belongs_to :employee, :class_name => "Employee"



  ACTIVE = 1
  INACTIVE = 2

  def self.search(from_date, to_date)
    if from_date && to_date
    	includes(:project).includes(:employee)
			.includes(:seat)
            .where(:status => ACTIVE)
            .where(:assignment_date => from_date.beginning_of_day..to_date.end_of_day)
      		.order('id DESC')
    else
      nil 
    end
  end

end
