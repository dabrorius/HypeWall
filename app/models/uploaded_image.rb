class UploadedImage < Item

  has_attached_file :attachment, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment :attachment, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  def url
    attachment.url
  end
end