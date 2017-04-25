// TODO: don't invoke when not logged in

// jQuery(document).ready(function () {
  App.messenger = App.cable.subscriptions.create("MessagesChannel", {
    messages: {},

    connected: function () {
      // Called when the subscription is ready for use on the server
    },

    disconnected: function () {
      // Called when the subscription has been terminated by the server
    },

    received: function (message) {
      // TODO: get current_user_id from somewhere!
      var id = message.from_user_id === current_user_id ? message.to_user_id : message.from_user_id
      this.messages[id] = this.messages[id] || []
      this.messages[id].push(message)

      var event = new CustomEvent("messenger")
      document.dispatchEvent(event)
      console.log(message) // { from_user_id:, to_user_id:, body:, updated_at: }
    },

    send_message: function (to_user_id, body) {
      this.perform('send_message', {to_user_id: to_user_id, body: body})
    }
  })
// })
