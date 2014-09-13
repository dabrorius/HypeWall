class WallsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :frame]
  before_action :set_wall, only: [:edit, :update, :destroy, :control,
   :remove_background, :remove_logo, :test_sockets, :history]

  # GET /walls
  def index
    @menu = 'dashboard'
    @walls = current_user.walls
  end

  # GET /walls/1
  def show
    @wall = Wall.friendly.find(params[:id])
    authenticate_user! unless @wall == Wall.example
    render layout: 'presentation'
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

  def test_sockets
    # this method is used to test pushing through websockets
    # load this method and look for changes on the wall control
    push_to_item_control(@wall.items.first)
    push_to_wall(@wall.items.first)
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
