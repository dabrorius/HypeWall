ActiveAdmin.register Wall do
  before_filter :only => [:show, :edit, :update, :destroy] do
    @wall = Wall.friendly.find(params[:id])
  end

  to_permit = [:name, :hashtag, :description, :created_at, :updated_at,
      :background_style, :require_image_approval, :font_color, :font_style,
      :slug, :background_color]



  permit_params to_permit

  index do
    # creates an appropriate column in the index view
    to_permit.each { |field| column field }
    # allows crud actions
    actions
  end

  form do |f|
    f.inputs "User details" do
      to_permit.each { |field| f.input field }
    end
    f.actions
  end
end
