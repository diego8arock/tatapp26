class User < ApplicationRecord
  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end

  def is_admin?
    has_role?(:admin)
  end

  def is_employee?
    has_role?(:employee)
  end

  def employee
    if self.is_employee?
      return Employee.find_by_number(self.username)
    else
      return nil
    end
  end
end
