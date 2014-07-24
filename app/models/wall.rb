class Wall < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  BACKGROUND_STYLES = ['center','tile','stretch']

  has_attached_file :background_image, :styles => { :thumb => "300x300>" }, :default_url => "/images/:style/missing.png"
  has_attached_file :logo, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :background_image, :content_type => /\Aimage\/.*\Z/
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  validates :hashtag, uniqueness: true

  has_many :wall_roles
  has_many :images

  def instagram_subscribe(webhook)
    Thread.new do |t|
      Instagram.create_subscription('tag', "#{webhook}", object_id: hashtag)
      get_instagram_images
      t.exit
    end
  end

  def recent_instagram_images
    images = []
    Instagram.tag_recent_media(hashtag).each do |instagram_image|
      unless Image.find_by_original_id(instagram_image.id).present?
        images.push Image.create(
          original_id: instagram_image.id,
          user_id: instagram_image.user.id,
          url: instagram_image.images.standard_resolution.url,
          wall_id: self.id)
      end
    end
    return images
  end

  def new_images
    recent_instagram_images
  end
end
