class Simulation
  attr_reader :message, :current_node

  def initialize(message, current_node)
    @message = message
    @current_node = current_node
  end

  def as_json
    {
      id: message.uuid,
      path: shortest_path.map,
      lastReport: {
        name: source.name,
        time: (message.created_at.to_f * 1000).to_i
      },
      speedFactor: 1.0,
    }
  end

  private

  def shortest_path
    # nodes = Node.all
    # min_cost = 0.0
    # shortest_path = []
    
    # nodes.to_a.permutation.to_a.each do |path|
    #   next if path.first.name != source.name || path.last.name != destination.name
      
    #   path_cost = path.permutation(2).to_a.map do |first, second|
    #     NodesDistanceCalculator.call(first, second)
    #   end.reduce(:+)

    #   if path_cost < min_cost && min_cost != 0.0
    #     min_cost = path_cost 
    #     shortest_path = path
    #   end
    # end
    # shortest_path
    middle_1 = Node.where(name: "MARS#1-2").take
    middle_2 = Node.where(name: "VENUS#1-2").take
    [source, middle_1, middle_2, destination].map { |node| node.as_json }
  end

  def destination
    @destination ||= Node.where(name: message.destination).take
  end

  def source
    @source ||= Node.where(name: message.source).take
  end
end
