class PropagationsController < ApplicationController
  def create
    InvalidateNodesService.call(params[:nodes], current_node)
    head :ok
  end
end
