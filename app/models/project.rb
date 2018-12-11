class Project < ApplicationRecord
  validates :name, :tag, :status, presence: true
  has_many :seats
  has_many :employees
  has_many :assignments

	ACTIVE = 1
	INACTIVE = 2
end
