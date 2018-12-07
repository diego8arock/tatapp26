class Seat < ApplicationRecord

  belongs_to :project, :foreign_key => "project_id"
  belongs_to :map, :foreign_key => "map_id"
  has_many :assignments

    ACTIVE = 1
    INACTIVE = 2
    UNAVAILABLE = 3
end
