var MessengerWindow = React.createClass({
  componentDidMount: function () {
    document.addEventListener('messenger', this._listenToMessenger)
  },

  componentWillUnmount: function () {
    document.removeEventListener('messenger', this._listenToMessenger)
  },

  _listenToMessenger: function () {
    this.setState({ messages: App.messenger.messages })
  },

  render: function () {
    const userMessages = this.state.messages[this.props.user.id]
    return (
      <div>
        {userMessages.map(function(message) {
          return <div>{message.body}</div>
        })}
      </div>
    )
  }
})

// Used by the component that creates MessengerWindow
// render() {
//   return (
//     <div>
//       <MessengerWindow user={teacher} />
//     </div>
//   )
// }