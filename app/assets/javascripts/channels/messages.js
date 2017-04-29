// TODO: don't invoke when not logged in
function idExists (messages, id) {
  for (var i = 0; i<messages.length; i++) {
    if (messages[i]['id'] == id) {
      return true
    }
  }
}
// jQuery(document).ready(function () {
  App.messenger = App.cable.subscriptions.create("MessagesChannel", {
    messages: {},

    connected: function () {
      // Called when the subscription is ready for use on the server
    },

    disconnected: function () {
      // Called when the subscription has been terminated by the server
    },

    received: function (payload) {
      // TODO: get current_user_id from somewhere!
      var message = payload.message;
      var id = message.from_user_id === currentUserId ? message.to_user_id : message.from_user_id
      this.messages[id] = this.messages[id] || []
      
      if (!idExists(this.messages[id], message['id'])) {
        this.messages[id].push(message)
        this.messages[id].sort(function(messageA, messageB) {
          return messageA.id - messageB.id
        })

        var event = new CustomEvent("messenger")
        document.dispatchEvent(event)
        console.log("Message: ", message)
        console.log("Messages: ", this.messages) // { from_user_id:, to_user_id:, body:, updated_at: }
        // { from_user_id:, to_user_id:, body:, updated_at: }
      }
    },

    send_message: function (to_user_id, body) {
      this.perform('send_message', {to_user_id: to_user_id, body: body})
    }
  })
// })
