module ApplicationHelper
  def websocket_host
    ENV['WEBSOCKET_HOST'] || "localhost:3000/websocket"
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def self.control_wall_size
    #6
    20
  end

  # makes using this method less verbose in the view
  def control_wall_size
    ApplicationHelper.control_wall_size
  end
end
