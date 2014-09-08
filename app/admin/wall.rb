ActiveAdmin.register Wall do

  # needed to due to friendly find IDs
  before_filter :only => [:show, :edit, :update, :destroy] do
    @wall = Wall.friendly.find(params[:id])
  end

  to_permit = [:name, :hashtag, :description, :created_at, :updated_at,
      :background_style, :require_image_approval, :font_color, :font_style,
      :slug, :background_color]

  permit_params to_permit

  index do
    column :name
    column :hashtag
    column :created_at
    column :updated_at
    column :require_image_approval
    actions
  end

  form do |f|
    f.inputs "Wall details" do
      to_permit.each { |field| f.input field }
    end
    f.actions
  end
end
