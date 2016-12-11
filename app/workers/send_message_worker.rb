class SendMessageWorker
  include Sidekiq::Worker

  def perform(host, message.id)
    message = Message.where(uuid: message_uuid).take
    NodeService.new(host).send_message(message)
  end
end

