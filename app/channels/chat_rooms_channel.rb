class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_room"
  end

  # def subscribed
  #   ActionCable.server.broadcast current_user, current_user
  # end

  def unsubscribed
  end

  def send_message(data)
    ActionCable.server.broadcast("chat_room", {
      message: render_message(data['message'])
    })
  end

  def render_message(message)
    Rails.logger.warn "[[[#{message}]]]"
    ChatRoomsController.render({
      partial: 'chat_rooms/message',
      locals: { user: current_user, message: message }
    })
  end
end
