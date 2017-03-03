class PropagateNodesService
  def initialize
    @current_node = Node.where(name: Redis.current.get('node_name')).take
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    hosts.each do |host|
      propagate_nodes_to(host)
    end
  end

  private

  attr_reader :current_node

  def hosts
    Node.where.not(id: @current_node.id).pluck(:host)
  end

  def propagate_nodes_to(host)
    NodeService.new(host).propagate(nodes_params)
  end

  def nodes_params
    @nodes_params ||= begin
      Node.select(:name, :host, :location_x, :location_y, :location_z).map do |node|
        node.as_json(except: :id)
      end
    end
  end
end
