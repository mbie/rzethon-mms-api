class Simulation
  attr_reader :message, :current_node

  def initialize(message, current_node)
    @message = message
    @current_node = current_node
  end

  def as_json
    {
      id: message.id,
      path: path.map { |node| node.as_json2 },
      lastReport: {
        name: source.name,
        time: (message.created_at.to_f * 1000).to_i
      },
      speedFactor: 1.0,
    }
  end

  def path
    shortest_path
  end

  private

  def shortest_path
    PathService.new.recalculate[message.destination].collect { |name| Node.where(name: name).take }
  end

  def destination
    @destination ||= Node.where(name: message.destination).take
  end

  def source
    @source ||= Node.where(name: message.source).take
  end
end
