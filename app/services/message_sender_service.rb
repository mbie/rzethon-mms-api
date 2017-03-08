class MessageSenderService
  attr_reader :message, :current_node

  def initialize(message)
    @message = message
    @current_node = Node.where(name: Redis.current.get('node_name')).take
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    send_message
  end

  private

  def send_message
    Rails.logger.debug "Message uuid: #{message.id} will be sent in #{time_remaning_to_next_node} seconds to #{current_node.host}"
    SendMessageWorker.perform_in(time_remaning_to_next_node.seconds, destination_node.host, message.id)
  end

  def time_remaning_to_next_node
    distance = NodesDistanceCalculator.call(current_node, destination_node)
    (DistanceToTimeConverter.new(distance).time.presence || 1)/ 10
  end

  def destination_node
    @destination_node ||= begin
      source = Node.where(name: message.source)
      simulation = Simulation.new(message, source)
      #binding.pry
      index = simulation.path.index(current_node)
      simulation.path[index+1]
    end
  end
end
