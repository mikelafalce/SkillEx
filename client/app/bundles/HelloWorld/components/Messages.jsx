import React from "react"

var MessengerWindow = React.createClass({
  getInitialState: function() {
     return {
       messages: []
     };
   },
  componentDidMount: function () {
    document.addEventListener('messenger', this._listenToMessenger)
  },

  componentWillUnmount: function () {
    document.removeEventListener('messenger', this._listenToMessenger)
  },

  _listenToMessenger: function () {
    this.setState({ messages: App.messenger ? App.messenger.messages : [] })
  },

  render: function () {
    const userMessages = this.state.messages
    // [this.props.user]
    // debugger
    return (
      <div>
        {Object.keys(userMessages).map(function(userId) {
          const messagesForUser = userMessages[userId]
          return messagesForUser.map(function(message) {  
            return <div>{message.body} from {message.from_user.email} to {message.to_user.email}</div>
          })
        })}
      </div>
    )
  }
})

export default MessengerWindow