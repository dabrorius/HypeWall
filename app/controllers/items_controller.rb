class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_wall_permission, only: [:new, :create]
  load_and_authorize_resource except: [:new, :create]

  def approve
    @item.approve
    render :change_status
  end

  def ban
    @item.ban
    render :change_status
  end

  def new
  end

  def create
    params[:images_attributes].each_with_index do |image, index|
      UploadedImage.create(uploaded_image_params(index).merge(status: 'approved').merge(wall: @wall))
    end
    redirect_to control_wall_path(@wall)
  end

  private

    def uploaded_image_params(index)
      params.require(:images_attributes)[index].permit(:attachment)
    end

    # this is used instead of cancan for authorization, because cancan has problems with nested resources
    def check_wall_permission
      @wall = Wall.friendly.find(params[:id])
      unless current_user.is_admin? || @wall.users.pluck(:id).include?(current_user.id)
        redirect_to root_path
      end
    end
end
