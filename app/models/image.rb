class Image < ActiveRecord::Base
  STATUSES = ['pending_approval','approved','banned']

  scope :unpresented, -> { where('presented = ?', false).order('created_at ASC') }

  def self.next
    image = Image.first
    new_images = Image.where('presented = ?', false).order('created_at ASC')
    if new_images.present?
      image = new_images.first
      image.update_attributes(presented: true)
    else
      last_fetched = Rails.cache.fetch('last_fetched') || 0
      current_image = (last_fetched + 1) % Image.count;
      Rails.cache.write('last_fetched', current_image)
      image = Image.offset(current_image).first
    end
    unless image.original_id.nil?
      begin
        likes = Instagram.media_likes(image.original_id).count
        image.update_attributes(likes: likes)
      rescue
      end
    end
    return image
  end
end
