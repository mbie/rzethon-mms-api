class NodeSubmissionWorker
  include Sidekiq::Worker
  sidekiq_options dead: false

  def perform(host)
    # client = NodeService.new(host)
    # client.submit(host)
  end
end
