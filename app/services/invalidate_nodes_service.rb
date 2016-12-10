class InvalidateNodesService
  def initialize(nodes)
    @nodes = nodes
  end

  def self.call(*args)
    new(*args).call
  end

  def call
  end

  private

  attr_reader :nodes
end
