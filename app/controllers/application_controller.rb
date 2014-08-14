class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def push_to_image_control(image)
    WebsocketRails[:"image_control_#{image.wall.id}"].trigger 'new', render_to_string(image)
  end

  def after_sign_in_path_for(resource)
	  dashboard_path
	end
end
