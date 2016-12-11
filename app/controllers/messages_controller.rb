class MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    if message.save
      render json: { message: message.reload }
    else
      render json: { error: message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def index
    render json: { messages: Message.all }
  end
end
