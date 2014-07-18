class Wall < ActiveRecord::Base
  has_attached_file :background_image, :styles => { :thumb => "300x300>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :background_image, :content_type => /\Aimage\/.*\Z/

  has_many :wall_roles
  has_many :images
end
