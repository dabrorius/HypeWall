class WallsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wall, only: [:show, :edit, :update, :destroy, :frame]

  # GET /walls
  # GET /walls.json
  def index
    @walls = current_user.walls
  end

  # GET /walls/1
  # GET /walls/1.json
  def show
    @wall_instance_id = SecureRandom.uuid
    render layout: 'application_fullscreen'
  end

  # GET /walls/new
  def new
    @wall = Wall.new
  end

  # GET /walls/1/edit
  def edit
  end

  # POST /walls
  # POST /walls.json
  def create
    @wall = Wall.new(wall_params)

    respond_to do |format|
      if @wall.save
        WallRole.create(user: current_user, wall: @wall)
        format.html { redirect_to @wall, notice: 'Wall was successfully created.' }
        format.json { render :show, status: :created, location: @wall }
      else
        format.html { render :new }
        format.json { render json: @wall.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /walls/1
  # PATCH/PUT /walls/1.json
  def update
    respond_to do |format|
      if @wall.update(wall_params)
        format.html { redirect_to @wall, notice: 'Wall was successfully updated.' }
        format.json { render :show, status: :ok, location: @wall }
      else
        format.html { render :edit }
        format.json { render json: @wall.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /walls/1
  # DELETE /walls/1.json
  def destroy
    @wall.destroy
    respond_to do |format|
      format.html { redirect_to walls_url, notice: 'Wall was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Renders a partial with new set of images
  # It's animated and added to wall
  def frame
    # Instance of wall, it's uniqe to each opened window.
    # This enables using multiple parallel walls
    instance_id = params[:instance_id]

    # Id of newest image that have been shown on this wall
    # All images with id larger than this are considered new and have precedence
    newest_in_circulation = session[:"#{instance_id}_newest_in_circulation"] || 0
    first_presented =  session[:"#{instance_id}_first_presented"] || 0
    last_presented = session[:"#{instance_id}_last_presented"] || 0

    # Layout id of images on wall, it's circulated
    session[:"#{instance_id}_current_frame"] ||= 0
    @current_frame = session[:"#{instance_id}_current_frame"]

    images_per_frame = 4
    # Fetch images that have just been uploaded
    new_images = @wall.images.where('id > ?', newest_in_circulation).order('id ASC').limit(4)

    # Fetch images that come after the last presented
    old_images_next = @wall.images.where('id > ?', last_presented).order('id ASC').limit(images_per_frame - new_images.count)
    # Fetch images from the begining of cyclus if full circle was made
    old_images_previous = @wall.images.order('id ASC').limit(images_per_frame - new_images.count - old_images_next.count)
    old_images = old_images_next.concat(old_images_previous)

    Rails.logger.debug "New images #{new_images.pluck(:id)}"
    Rails.logger.debug "Old images #{old_images_next.pluck(:id)} + #{old_images_previous.pluck(:id)} = #{old_images}"

    session[:"#{instance_id}_newest_in_circulation"] = new_images.last.id if new_images.last
    session[:"#{instance_id}_first_presented"] = old_images.first.id if old_images.first
    session[:"#{instance_id}_last_presented"] = old_images.last.id if old_images.last

    total_frames = 3
    session[:"#{instance_id}_current_frame"] = (session[:"#{instance_id}_current_frame"] + 1) % total_frames

    @photos = new_images.concat old_images
    render layout: false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wall
      @wall = current_user.walls.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wall_params
      params.require(:wall).permit(:name, :instagram_hashtag, :description)
    end
end
