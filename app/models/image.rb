class Image < ActiveRecord::Base

  def self.next
    new_images = Image.where('presented = ?', false).order('created_at ASC')
    if new_images.present?
      image = new_images.first
      image.update_attributes(presented: true)
      return image
    else
      offset = rand(Image.count)
      return Image.offset(offset).first
    end
  end
end
