class Image < ActiveRecord::Base

  belongs_to :wall

  STATUSES = ['pending_approval','approved','banned']

  def approve
    update_attribute :status, 'approved'
  end

  def ban
    update_attribute :status, 'banned'
  end

end
