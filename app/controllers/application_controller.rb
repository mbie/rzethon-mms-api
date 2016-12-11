class ApplicationController < ActionController::API
  def current_node
    Node.where(name: ENV["CURRENT_NODE_NAME"]).first
  end
end
