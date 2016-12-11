class SimulationsController < ApplicationController
  def index
    messages = Message.current.map do |message|
      Simulation.new(message, current_node).as_json
    end

    render json: { messages: messages }
  end
end
