class ImagesController < ApplicationController

  before_action :set_image, only: [:approve, :ban]

  def approve
    @image.approve
    render :change_status
  end

  def ban
    @image.ban
    render :change_status
  end

  def create
    @wall = current_user.walls.find(params[:id])
    UploadedImage.create(uploaded_image_params.merge(status: 'approved').merge(wall: @wall))
    redirect_to control_wall_path(@wall)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = current_user.images.find(params[:id])
    end

    def uploaded_image_params
      params.require(:uploaded_image).permit(:attachment)
    end
end
