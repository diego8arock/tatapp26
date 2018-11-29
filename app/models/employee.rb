class Employee < ApplicationRecord
  validates :number, presence: true, uniqueness: true

  MOBILE = 1
  FIXED = 2

  ACTIVE = 1
  INACTIVE = 2
end
