class Wall < ActiveRecord::Base

  def self.example
    Wall.find(ENV['EXAMPLE_WALL_ID'])
  end

  include Rails.application.routes.url_helpers

  BACKGROUND_STYLES = ['center','tile','stretch']

  has_attached_file :background_image, :styles => { :thumb => "300x300>" }, :default_url => "/images/:style/missing.png"
  has_attached_file :logo, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :background_image, :content_type => /\Aimage\/.*\Z/
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  validates :hashtag, presence: true
  validates :hashtag, uniqueness: true

  has_many :wall_roles
  has_many :images

  accepts_nested_attributes_for :images, :allow_destroy => true

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

  def instagram_subscription
    (Instagram.subscriptions.select{ |subscription|
      subscription['object_id'] == self.hashtag }).first
  end

  def instagram_unsubscribe
    Instagram.delete_subscription(id: instagram_subscription.id)
  end

end
