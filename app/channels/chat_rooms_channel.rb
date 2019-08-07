class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_room"
    ActionCable.server.broadcast "chat_room", { user: current_user }
  end

  def unsubscribed
  end

  def send_message(data)
    ActionCable.server.broadcast("chat_room", {
      message: render_message(data['message'])
    })
  end

  def render_message(message)
    ChatRoomsController.render({
      partial: 'chat_rooms/message',
      locals: { user: current_user, message: message }
    })
  end
end
