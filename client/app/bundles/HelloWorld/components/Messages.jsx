import React from "react";
import ReactDOM from 'react-dom';
import Modal, {closeStyle} from 'simple-react-modal'

var MessengerWindow = React.createClass({
  getInitialState: function() {
     return {
       messages: [],
       messagesById: [],
       messageValue: '',
       recipientId: null
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

  submitNewMessage: function (e) {
    e.preventDefault();
    App.messenger.send_message(this.state.recipientId, this.state.messageValue)
  },

  handleMessageChange: function (e) {
    e.preventDefault();
    this.setState({messageValue:e.target.value})
  },

  showHandleClick: function (e){
    const messagesById = this.state.messages[e.target.getAttribute('id')];
    this.setState({messagesById: messagesById, show:true, recipientId:e.target.getAttribute('id')})
  },
 
  close: function (){
    this.setState({show: false})
  },

  render: function () {
    const userMessages = this.state.messages
    
    return (
      <div>
        <div onClick={this.showHandleClick}>
                {Object.keys(userMessages).map(function(userId) {
                  const messagesForUser = userMessages[userId]
                  const test = messagesForUser.map(function(message) {  
                    return <div id={userId}>{message.body} from {message.from_user.first_name} to {message.to_user.first_name}</div>
                  })
                  return test[test.length - 1]
                })}
        </div>
          <Modal
                className="test-class" //this will completely overwrite the default css completely 
                style={{background: 'red'}} //overwrites the default background 
                containerStyle={{background: 'blue'}} //changes styling on the inner content area 
                containerClassName="test"
                closeOnOuterClick={true}
                show={this.state.show}
                onClose={this.close}>
           
                <div>
                <a onClick={this.close}>Close this modal</a>
                {
                  this.state.messagesById.map(function(message) {  
                    return <div>{message.body} from {message.from_user.first_name} to {message.to_user.first_name}</div>
                  })
  }
                </div>
                <form onSubmit={this.submitNewMessage}>
                  <input type="text" onChange={this.handleMessageChange}/>
                  <input value="Submit" type="submit"/>
                </form>
          </Modal>
      </div>
    )
  }
})

export default MessengerWindow