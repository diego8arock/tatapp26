class Employee < ApplicationRecord
  validates :name, :number, :assignment_type, :status, :birth_date, :admission_date, presence: true
  validates :number, numericality: { only_integer: true }
  validates :number, length: { minimum: 6 }
  belongs_to :seat, optional: true
  belongs_to :project

  MOBILE = 1
  FIXED = 2

  ACTIVE = 1
  INACTIVE = 2

  def get_status
    if self.status == ACTIVE
      return "Active"
    else
      return "Inactive"
    end
  end

  def get_assignment_type
    if self.assignment_type == MOBILE
      return "Mobile"
    else
      return "Fixed"
    end
  end
end
