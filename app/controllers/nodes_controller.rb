class NodesController < ApplicationController
  @@names = [
    'EARTH#1.3', 'EARTH#2.3', 'EARTH#3.3',
    'VENUS#1.3', 'VENUS#2.3', 'VENUS#3.3',
    'MERCURY#1.3', 'MERCURY#2.3', 'MERCURY#3.3',
    'MARS#1.3', 'MARS#2.3', 'MARS#3.3'
  ]

  @@name_index = {}
  @@mutex = Mutex.new

  def index
    nodes = Node.all
    render json: { nodes: nodes }
  end

  def names
    render json: { names: @@name_index }
  end

  def register_name
    address = params['address']
    @@mutex.synchronize do
      if not @@name_index.include? address
        @@name_index[address] = @@names.select{ |n| not @@name_index.value? n }.first
      end

      puts address, @@name_index[address]
      render json: { name: @@name_index[address] }
    end
  end
end
