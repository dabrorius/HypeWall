class WallsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :frame]
  before_action :set_wall, only: [:edit, :update, :destroy, :control,
   :remove_background, :remove_logo, :test_sockets, :history, :activate_prompt, :activation]

  # GET /walls
  def index
    @menu = 'dashboard'
    @walls = current_user.walls
  end

  # GET /walls/1
  def show
    @wall = Wall.friendly.find(params[:id])
    authenticate_user! unless @wall == Wall.example
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
  def create
    @wall = Wall.new(wall_params)
    if @wall.save
      WallRole.create(user: current_user, wall: @wall)
      @wall.instagram_subscribe("#{root_url}instagram/webhook")
      redirect_to edit_wall_path(@wall), notice: 'Wall was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /walls/1
  def update
    @old_hashtag = @wall.hashtag.dup
    if @wall.update(wall_params)
      if @wall.hashtag != @old_hashtag
        @wall.instagram_unsubscribe
        @wall.images.destroy_all
        @wall.instagram_subscribe("#{root_url}instagram/webhook")
      end
      redirect_to edit_wall_path(@wall), notice: 'Wall was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /walls/1
  def destroy
    @wall.destroy
    redirect_to walls_url, notice: 'Wall was successfully destroyed.'
  end

  def control
    @images = @wall.items.limit(ApplicationHelper.control_wall_size)
  end

  def history
    @items = @wall.items.order(created_at: :desc).paginate(:page => params[:page], :per_page => 6)
  end

  def remove_background
    @wall.background_image = nil
    @wall.save
    redirect_to edit_wall_path(@wall)
  end

  def remove_logo
    @wall.logo = nil
    @wall.save
    redirect_to edit_wall_path(@wall)
  end

  def activate_prompt
  end

  def activation
    puts @wall.id.to_s + "=============="
    activation_code = ActivationCode.where(code: params[:activation_code])
    unless activation_code.blank?
      activation_code[0].wall_id = @wall.id
      activation_code[0].save
    else
      flash[:alert] = "Your activation code was rejected"
    end
    redirect_to dashboard_path
  end

  # Renders a partial with new set of images
  # It's animated and added to wall
  def frame
    @wall = Wall.friendly.find(params[:id])
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
    new_images = @wall.items.approved.where('id > ?', newest_in_circulation).order('id ASC').limit(4)

    # Fetch images that come after the last presented
    old_images_next = @wall.items.approved.where('id > ?', last_presented).order('id ASC').limit(images_per_frame - new_images.count)
    # Fetch images from the begining of cyclus if full circle was made
    old_images_previous = @wall.items.approved.order('id ASC').limit(images_per_frame - new_images.count - old_images_next.count)
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

  def test_sockets
    # this method is used to test pushing through websockets
    # load this method and look for changes on the wall control
    push_to_item_control(@wall.items.first)
    render text: "This is used to test websockets"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wall
      @wall = current_user.walls.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wall_params
      params.require(:wall).permit(:name, :hashtag, :description, :background_image, :background_style, :logo, :require_image_approval, :font_style, :font_color, :background_color)
    end
end
