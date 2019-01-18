class Seat < ApplicationRecord

  belongs_to :project
  belongs_to :map
  has_many :assignments
  has_many :employees

  ACTIVE = 1
  INACTIVE = 2
  UNAVAILABLE = 3
end
