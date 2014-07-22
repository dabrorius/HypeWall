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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = current_user.images.find(params[:id])
    end
end
