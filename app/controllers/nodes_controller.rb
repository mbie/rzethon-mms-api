class NodesController < ApplicationController
  #@@names = [
    #'EARTH#1.3', 'EARTH#2.3', 'EARTH#3.3',
    #'VENUS#1.3', 'VENUS#2.3', 'VENUS#3.3',
    #'MERCURY#1.3', 'MERCURY#2.3', 'MERCURY#3.3',
    #'MARS#1.3', 'MARS#2.3', 'MARS#3.3'
  #]

  # this setup solves 'through-sun' transmission and covers more planets
  # order matters as this as it tries to make simulation meaningful with 2-3 nodes already
  # sun roundabout works with more than 9-10 nodes, check it out
  @@names = [
    'EARTH#1.3',
    'MARS#1.1',
    'VENUS#1.1',
    'EARTH#2.3', 'EARTH#3.3',
    'MERCURY#1.6',
    'MERCURY#3.6', 'MERCURY#5.6', 'MERCURY#2.6', 'MERCURY#4.6', 'MERCURY#6.6',
    'JUPITER#1.3',
    'SATURN#1.1',
    'JUPITER#2.3', 'JUPITER#3.3',
    'URANUS#1.1',
    'NEPTUNE#1.1'
  ]

  #@@name_index = {}
  @@mutex = Mutex.new

  def index
    nodes = Node.all
    render json: { nodes: nodes }
  end

  def show
    render json: { node: Node.find(params[:id]) }
  end

  def me
    render json: { current_node: Node.where(name: Redis.current.get('node_name')) }
  end

  def names
    render json: { names: NAME_INDEX }
  end

  def register_name
    address = params['address']
    @@mutex.synchronize do
      if not NAME_INDEX.include? address
        NAME_INDEX[address] = @@names.select{ |n| not NAME_INDEX.value? n }.first
      end

      render json: { name: NAME_INDEX[address] }
    end
  end
end
