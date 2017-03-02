class SubmissionsController < ApplicationController
  def create
    node = Node.where(name: node_params[:name]).first_or_initialize
    node.assign_attributes(node_params)

    if node.save
      PropagationWorker.perform_async(node.id)
      render json: { message: node }
    else
      render json: { error: node.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def node_params
    params.require(:node).permit(:name, :host, :location_x, :location_y, :location_z)
  end
end
