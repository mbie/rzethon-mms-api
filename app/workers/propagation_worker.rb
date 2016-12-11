class PropagationWorker
  include Sidekiq::Worker
  sidekiq_options dead: false

  def perform(current_node_id)
    current_node = Node.find current_node_id
    PropagateNodesService.call(current_node)
  end
end

