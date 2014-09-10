class Wall < ActiveRecord::Base
  require 'tweetstream'
  extend FriendlyId
  friendly_id :name, use: :slugged

  def self.example
    Wall.find_by_id(ENV['EXAMPLE_WALL_ID'] || 1)
  end

  include Rails.application.routes.url_helpers

  BACKGROUND_STYLES = ['center','tile','stretch']
  FONT_COLORS = ['light','dark']
  FONT_STYLES = ['helvetica','lobster']

  has_attached_file :background_image, :styles => { :thumb => "300x300>" }, :default_url => "/images/:style/missing.png"
  has_attached_file :logo
  validates_attachment_content_type :background_image, :content_type => /\Aimage\/.*\Z/
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  has_many :wall_roles
  has_many :users, through: :wall_roles
  has_many :items, dependent: :destroy

  validates :name, presence: true
  validates :hashtag, presence: true

  accepts_nested_attributes_for :items, :allow_destroy => true

  before_save :hashtag_cleanup
  def hashtag_cleanup
    hashtag.gsub!('#','')
    hashtag.downcase!
  end


  def has_logo?
    logo.file?
  end

  def has_background?
    background_image.file?
  end

  def instagram_subscribe(webhook)
    Thread.new do |t|
      Instagram.create_subscription('tag', "#{webhook}", object_id: hashtag)
      get_instagram_images
      t.exit
    end
  end
  
  def twitter_subscribe
    TweetStream::Client.new.track(Wall.all.map{|x| "#" + x["hashtag"]}) do |tweet|
      
      hashtags = []
      tweet.hashtags.each do |h|
        hashtags << h.text.downcase
      end

      open('/Users/Dora/Desktop/HypeWall/log/probni.txt', 'a') { |f|
        f.puts "#{tweet.media}"
      }
      if tweet.media.present?
      url = "#{tweet.media[0].media_url}"
     else
      url = nil
     end
      Wall.where("hashtag IN (?)", hashtags).each do |w|
        TwitterItem.create(original_id: tweet.id, user_id: tweet.user.id, url: url, wall_id: w.id, text: tweet.text)
      end
    end
  end
    
  end


  def recent_instagram_images
    items = []
    Instagram.tag_recent_media(hashtag).each do |instagram_image|
      unless InstagramItem.find_by_original_id(instagram_image.id).present?
        items.push InstagramItem.create(
          original_id: instagram_image.id,
          user_id: instagram_image.user.id,
          url: instagram_image.images.standard_resolution.url,
          wall_id: self.id)
      end
    end
    return items
  end

  def new_items
    recent_instagram_images
  end

  def instagram_subscription
    (Instagram.subscriptions.select{ |subscription|
      subscription['object_id'] == self.hashtag }).first
  end

  def instagram_unsubscribe
    Instagram.delete_subscription(id: instagram_subscription.id)
  end
  
  def twitter_unsubscribe
    TweetStream::Client.stop
  end

  def owner
    wall_roles.order('created_at').first.user
  end

  def is_pro?
    owner.is_pro?
  end

end
