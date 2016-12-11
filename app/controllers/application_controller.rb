class ApplicationController < ActionController::API
  before_action :disable_cors

  def current_node
    Node.where(name: ENV["CURRENT_NODE_NAME"]).first
  end

  def disable_cors
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end
