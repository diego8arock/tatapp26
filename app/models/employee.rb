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
    if self.is_active?
      return I18n.t "active"
    else
      return I18n.t "inactive"
    end
  end

  def get_assignment_type
    if self.assignment_type == MOBILE
      return I18n.t "float"
    else
      return I18n.t "fixed"
    end
  end

  def is_active?
    self.status == ACTIVE
  end
end
