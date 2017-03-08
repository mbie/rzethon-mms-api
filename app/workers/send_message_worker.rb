class SendMessageWorker
  include Sidekiq::Worker

  def perform(host, message_uuid)
    message = Message.where(id: message_uuid).take
    NodeService.new(host).send_message(message)
  end
end

