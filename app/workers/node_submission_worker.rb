class NodeSubmissionWorker
  include Sidekiq::Worker
  sidekiq_options dead: false
  @@semafor = Mutex.new

  def perform(base_host, current_host, name)
    @@semafor.synchronize do
      # when DEMO variable set, try to initialize local host ip as current nodes address
      # also get name from the first node to allow dynamic scaling, without bulky config
      if ENV['DEMO']
        current_ip = `ip addr | awk -F'/|\s+' '/global/ {print $3}'`.strip
        current_host = "http://#{current_ip}:3000"
        Redis.current.set('current_host', current_host)

        name = JSON.parse(Faraday.put(
          base_host+'/nodes/register_name', {'address'=>current_host}
        ).body)['name']
        Redis.current.set('node_name', name)
      end

      return if not ActiveRecord::Base.connection.data_source_exists? 'nodes'
      return if Node.where(name: name).any?

      location = NodeLocationService.new(name).get_location

      node_params = {
        host: current_host,
        name: name
      }.merge(location.attributes)

      node = Node.where(name: node_params[:name]).first_or_initialize
      node.assign_attributes(node_params)
      node.save!

      client = NodeService.new(base_host)
      client.submit(node.as_json(except: :id))
    end
  end
end
