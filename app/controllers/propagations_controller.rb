class PropagationsController < ApplicationController
  def create
    InvalidateNodesService.call(params[:nodes])
    head :ok
  end
end
