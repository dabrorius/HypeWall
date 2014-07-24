module ApplicationHelper
  def websocket_host
    ENV['WEBSOCKET_HOST']
  end
end
