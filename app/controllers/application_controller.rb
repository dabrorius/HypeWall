class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception  

  def push_to_item_control(item)
    WebsocketRails[:"item_control_#{item.wall.id}"].trigger 'new', render_to_string(item)
  end

  def push_to_wall(item)
    WebsocketRails[:"wall_#{item.wall.id}"].trigger 'new', item.to_json
  end

  def remove_from_wall(item)
    WebsocketRails[:"wall_#{item.wall.id}"].trigger 'remove', item.id
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def authenticate_admin_user!    
    if current_user.nil? || !current_user.is_admin?
      flash[:alert] = "This page is restricted"
      redirect_to root_path
    end
  end 

end
