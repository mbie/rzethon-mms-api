class NodeSubmissionWorker
  include Sidekiq::Worker
  sidekiq_options dead: false

  def perform(base_host, current_host, name)
    location = NodeLocationService.new(name).get_location

    node_params = {
      host: current_host,
      name: name
    }.merge(location.attributes)

    node = Node.create!(node_params)
    
    client = NodeService.new(base_host)
    client.submit(node.as_json(except: :id))
  end
end
