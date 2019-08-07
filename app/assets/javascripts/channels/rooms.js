$(function() {
  var messages = $('#messages')

  if ($('#messages').length > 0) {
    App.global_chat = App.cable.subscriptions.create({
      channel: "ChatRoomsChannel"
    }, {
      connected: function() {},
      disconnected: function() {},
      received: function(data) {
        if (data.hasOwnProperty('user')) {
          messages.prepend(`<h2>Hi ${data.user}, welcome!</h2>`);
        } else if (data.hasOwnProperty('message')) {
          messages.append(data['message']);
        }
      },
      send_message: function(message) {
        return this.perform('send_message', {
          message: message
        });
      }
    });

    $('#new_message').submit(function(e) {
      var $this = $(this),
          textarea = $this.find('#message_body');

      if ($.trim(textarea.val()).length > 1) {
        App.global_chat.send_message(textarea.val(), messages.data('chat-room-id'));
        textarea.val('');
      }

      e.preventDefault();
    });
  }
})
