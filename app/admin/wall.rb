ActiveAdmin.register Wall do
  before_filter :only => [:show, :edit, :destroy] do
    @wall = Wall.friendly.find(params[:id])
  end
end
