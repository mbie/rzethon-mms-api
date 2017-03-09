class PropagationsController < ApplicationController
  def create
    InvalidateNodesService.call(params[:nodes].collect { |p| p.permit(:name, :host, :location_x, :location_y, :location_z)})
    head :ok
  end
end
