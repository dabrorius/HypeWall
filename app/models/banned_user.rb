class BannedUser < ActiveRecord::Base
	belongs_to :wall

	validates :wall_id, presence: true
  	validates :user_id, presence: true
end
