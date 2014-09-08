class Item < ActiveRecord::Base

  belongs_to :wall

  validates :wall, presence: true
  validates :status, presence: true

  STATUSES = ['pending_approval','approved','banned']
  validates :status, inclusion: { in: STATUSES }

  before_validation :set_status
  def set_status
    if status.blank?
      self.status = wall.require_image_approval ? 'pending_approval' : 'approved'
    end
  end

  scope :approved, -> { where("status = 'approved'") }

  def approve
    update_attribute :status, 'approved'
  end

  def ban
    update_attribute :status, 'banned'
  end
end
