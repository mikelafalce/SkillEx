import React from "react"

var MessengerWindow = React.createClass({
  getInitialState: function() {
     return {
       messages: []
     };
   },
  componentDidMount: function () {
    console.log(App)
    document.addEventListener('messenger', this._listenToMessenger)
  },

  componentWillUnmount: function () {
    document.removeEventListener('messenger', this._listenToMessenger)
  },

  _listenToMessenger: function () {
    this.setState({ messages: App.messenger ? App.messenger.messages : [] })
    debugger
  },

  render: function () {
    const userMessages = this.state.messages[this.props.user]
    return (
      <div>
        { userMessages && userMessages.map(function(message) {
          return <div>{message.body}</div>
        })}
      </div>
    )
  }
})

export default MessengerWindow