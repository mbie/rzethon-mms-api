class MessagesController < ApplicationController
  def create
    message = Message.new(message_params.merge(source: current_node.name))
    
    if message.save
      MessageSenderService.call(message.reload, current_node)
      render json: { message: message }
    else
      render json: { error: message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def message_params
    params.require(:message).permit(:content, :destination)
  end

  def index
    render json: { messages: Message.all }
  end
end
