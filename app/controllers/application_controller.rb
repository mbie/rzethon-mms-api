class ApplicationController < ActionController::API
  def current_node
    Node.new
  end
end
