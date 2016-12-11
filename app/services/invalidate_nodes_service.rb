class InvalidateNodesService
  def initialize(nodes, current_node)
    @nodes = nodes
    @current_node = current_node
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    changed = false
    
    nodes.each do |node_params|
      node = Node.where(name: node_params[:name]).first_or_initialize

      node.assign_attributes(node_params)
      if node.changed?
        changed = true if !changed 
        node.save! 
      end
    end

    if changed
      PropagateNodesService.call(current_node)
    end
  end

  private

  attr_reader :nodes, :current_node
end
