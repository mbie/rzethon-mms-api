require 'shortest/path'

class PathService
  attr_reader :paths, :graph

  def initialize()
    @paths = JSON.parse(Redis.current.get('paths') || "{}")
    if not @paths
      recalculate
    end
  end

  def build_graph
    graph = Shortest::Path::Graph.new.concat Node.all.collect { |n| n.name }
    graph.each { |i|
      graph.each { |j|
        graph.connect_mutually(i, j, 1)
      }
    }
    graph
  end

  def recalculate
    node_name = Redis.current.get('node_name')
    graph = build_graph

    dist = heur = ->(node1, node2){
      NodesDistanceCalculator.call(
        Node.where(name: node1).take,
        Node.where(name: node2).take
      )**2
    }

    @paths = Hash[ Node.where.not(name: node_name).collect { |n|
      [n.name, Shortest::Path.astar(dist, heur, graph, node_name, n.name)]
    } ]
    Redis.current.set('paths', @paths.to_json)
    @paths
  end
end
