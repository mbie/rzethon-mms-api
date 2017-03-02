class NodesController < ApplicationController
  @@names = [
    'EARTH#1.3', 'EARTH#2.3', 'EARTH#3.3',
    'VENUS#1.3', 'VENUS#2.3', 'VENUS#3.3',
    'MERCURY#1.3', 'MERCURY#2.3', 'MERCURY#3.3',
    'MARS#1.3', 'MARS#2.3', 'MARS#3.3'
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
