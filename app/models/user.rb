class User < ApplicationRecord
  has_secure_password

  validates :employee_number, presence: true, uniqueness: true
end
