class Seat < ApplicationRecord
  belongs_to :project

  
    ACTIVE = 1
    INACTIVE = 2
end