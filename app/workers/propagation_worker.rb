class PropagationWorker
  include Sidekiq::Worker
  sidekiq_options dead: false

  def perform
    PropagateNodesService.call
  end
end

