class Wall < ActiveRecord::Base
  has_many :wall_roles
  has_many :images
end
