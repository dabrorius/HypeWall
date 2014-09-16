class ItemsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: [:new, :create]
  # before_action :set_item, only: [:approve, :ban]

  def approve
    @item.approve
    render :change_status
  end

  def ban
    @item.ban
    render :change_status
  end

  def new
    @wall = Wall.friendly.find(params[:id])
    # this is used instead of cancan for authorization, because cancan has problems with nested resources
    unless check_wall_permission
      redirect_to root_path
    end
  end

  def create
    @wall = Wall.friendly.find(params[:id])
    unless check_wall_permission
      redirect_to root_path
    else
      params[:images_attributes].each_with_index do |image, index|
        UploadedImage.create(uploaded_image_params(index).merge(status: 'approved').merge(wall: @wall))
      end
      # UploadedImage.create(uploaded_image_params.merge(status: 'approved').merge(wall: @wall))
      redirect_to control_wall_path(@wall)
    end
  end

  private

    def uploaded_image_params(index)
      params.require(:images_attributes)[index].permit(:attachment)
    end

    def check_wall_permission
      current_user.is_admin? || @wall.users.pluck(:id).include?(current_user.id)
    end
end
