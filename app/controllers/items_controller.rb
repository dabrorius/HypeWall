class ItemsController < ApplicationController

  before_action :set_item, only: [:approve, :ban]

  def approve
    @item.approve
    push_to_wall @item
    render :change_status
  end

  def ban
    @item.ban
    remove_from_wall @item
    render :change_status
  end

  def new
    @wall = Wall.friendly.find(params[:id])
  end

  def create
    @wall = current_user.walls.friendly.find(params[:id])
    params[:images_attributes].each_with_index do |image, index|
      UploadedImage.create(uploaded_image_params(index).merge(status: 'approved').merge(wall: @wall))
    end
    # UploadedImage.create(uploaded_image_params.merge(status: 'approved').merge(wall: @wall))
    redirect_to control_wall_path(@wall)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = current_user.items.find(params[:id])
    end

    def uploaded_image_params(index)
      params.require(:images_attributes)[index].permit(:attachment)
    end
end
