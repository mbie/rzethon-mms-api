class InvalidateNodesService
  def initialize(nodes)
    @nodes = nodes
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    changed = false

    Node.transaction do
      nodes.each do |node_params|
        node = Node.where(name: node_params[:name]).lock(true).first_or_initialize

        node.assign_attributes(node_params)
        if node.changed?
          changed = true if !changed
          node.save!
        end
      end
    end

    if changed
      PropagationWorker.perform_async
      PathService.new.recalculate
    end
  end

  private

  attr_reader :nodes
end
