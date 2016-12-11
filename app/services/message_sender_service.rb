class MessageSenderService
  attr_reader :message, :current_node

  def initialize(message, current_node)
    @message = message
    @current_node = current_node
  end

  def call
    send_message
  end

  private

  def send_message
    SendMessageWorker.perform_in(1.minute, current_node.host, message.id)
  end
end
