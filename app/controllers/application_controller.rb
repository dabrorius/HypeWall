class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # makes cancan redirect to root
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def push_to_item_control(item)
    WebsocketRails[:"item_control_#{item.wall.id}"].trigger 'new', render_to_string(item)
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  # used by active admin to verify admin
  def authenticate_admin_user!
    if current_user.nil? || !current_user.is_admin?
      flash[:alert] = "This page is restricted"
      redirect_to root_path
    end
  end

end
