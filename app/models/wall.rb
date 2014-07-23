class Wall < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  BACKGROUDN_STYLES = ['center','tile','stretch']

  has_attached_file :background_image, :styles => { :thumb => "300x300>" }, :default_url => "/images/:style/missing.png"
  has_attached_file :logo, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :background_image, :content_type => /\Aimage\/.*\Z/

  validates :instagram_hashtag, uniqueness: true

  has_many :wall_roles
  has_many :images

  def instagram_subscribe(webhook)
    Thread.new do |t|
      Instagram.create_subscription('tag', "#{webhook}", object_id: instagram_hashtag)
      get_instagram_images
      t.exit
    end
  end

  def get_instagram_images()
    images = Instagram.tag_recent_media(instagram_hashtag)
    images.each do |image|
      unless Image.find_by_original_id(image.id).present?
        Image.create(
          original_id: image.id,
          user_id: image.user.id,
          url: image.images.standard_resolution.url,
          wall_id: self.id)
      end
    end
  end
end
