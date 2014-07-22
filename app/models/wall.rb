class Wall < ActiveRecord::Base
  BACKGROUDN_STYLES = ['center','tile','stretch']

  has_attached_file :background_image, :styles => { :thumb => "300x300>" }, :default_url => "/images/:style/missing.png"
  has_attached_file :logo, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :background_image, :content_type => /\Aimage\/.*\Z/

  has_many :wall_roles
  has_many :images
end
