import consumer from "./consumer"

consumer.subscriptions.create({ channel: "ChatRoomChannel", chat_room_id: YOUR_CHAT_ROOM_ID }, {
  received(data) {
    // Called when there's incoming data on the websocket for this channel
    $('#messages').append(data['message']);
  }
});

$('#new_message').submit(function(e) {
  e.preventDefault();
  const messageContent = $('#message_content').val();
  consumer.send({ message: messageContent });
  $('#message_content').val('');
});
