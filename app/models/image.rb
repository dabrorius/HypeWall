class Image < ActiveRecord::Base

  def self.next
    new_images = Image.where('presented = ?', false).order('created_at ASC')
    if new_images.present?
      image = new_images.first
      image.update_attributes(presented: true)
      return image
    else
      last_fetched = Rails.cache.fetch('last_fetched') || 0
      current_image = (last_fetched + 1) % Image.count;
      last_fetched = Rails.cache.write('last_fetched', current_image)
      return Image.offset(current_image).first
    end
  end
end
