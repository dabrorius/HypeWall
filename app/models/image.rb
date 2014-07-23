class Image < ActiveRecord::Base

  belongs_to :wall

  before_save :set_status
  def set_status
    if status.blank?
      self.status = wall.require_image_approval ? 'pending_approval' : 'approved'
    end
    true
  end

  scope :approved, -> { where("status = 'approved'") }

  STATUSES = ['pending_approval','approved','banned']

  def approve
    update_attribute :status, 'approved'
  end

  def ban
    update_attribute :status, 'banned'
  end

end
