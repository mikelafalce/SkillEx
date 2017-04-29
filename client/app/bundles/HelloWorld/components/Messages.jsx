import React from "react"

var MessengerWindow = React.createClass({
  getInitialState: function() {
     return {
       messages: [],
       convo: false
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

  _handleClick: function () {
    this.setState({
      convo: true
    })
  },

  render: function () {
    const userMessages = this.state.messages
    // [this.props.user]
    // debugger
    return (
      <div onClick={this._handleClick}>
              {Object.keys(userMessages).map(function(userId) {
                const messagesForUser = userMessages[userId]
                const test = messagesForUser.map(function(message) {  
                  return <div>{message.body} from {message.from_user.first_name} to {message.to_user.first_name}</div>
                })
                return test[test.length - 1]
              })}
      </div>
    )
  }
})

export default MessengerWindow