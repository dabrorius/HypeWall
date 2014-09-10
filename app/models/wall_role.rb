class WallRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :wall

  validates :user, presence: true
  validates :wall, presence: true
end
