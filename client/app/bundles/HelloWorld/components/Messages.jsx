import React from "react";
import ReactDOM from 'react-dom';
import Modal, {closeStyle} from 'simple-react-modal'
import Conversations from './Conversations';

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
    const re = /=(\d+)/
    const passInId = document.location.search.match(re)
    if (passInId) {
      const id = Number(passInId[1])
      this.showConversation({userId : id})
    }
  },

  componentWillUnmount: function () {
    document.removeEventListener('messenger', this._listenToMessenger)
  },

  _listenToMessenger: function () {
    //activate id in messages.js
    this.setState({
      messages: App.messenger ? App.messenger.messages : [],
      messagesById: App.messenger.messages[this.state.recipientId]
    })
    this.refs.scrollWindow.scrollTop = 1000000000
  },

  submitNewMessage: function (e) {
    e.preventDefault();
    App.messenger.send_message(this.state.recipientId, this.state.messageValue)
    this.refs.input.value = ""
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

  showConversation :  function(conversation){
    const userId = conversation.userId;
    const messagesById = this.state.messages[userId] || [];
    this.setState({messagesById: messagesById, show:true, recipientId:userId});
    this.refs.input.value = ""
  },

  render: function () {
    const userMessages = this.state.messages
    const conversations = Object.keys(userMessages).map(function(userId) {
                  const messagesForUser = userMessages[userId];
                  const lastMessage = messagesForUser[messagesForUser.length-1];

                  return {
                    lastMessage,
                    userId
                  }
                });
    console.log(conversations);
    return (
      <div>
      
      <div className="messages-container"> 
       <Conversations conversations={conversations} onConversationClick={this.showConversation} />

          <Modal
                className="message-detail" 
                containerClassName="message-detail-inner"
                closeOnOuterClick={true}
                show={this.state.show}
                onClose={this.close}>
                <div ref="scrollWindow">
                <a className="closeWindow" onClick={this.close}>Close</a>
                {
                  this.state.messagesById.map(function(message) {  
                    console.info(message,currentUserId);
                    const mClassName = "message " + (message.from_user_id == currentUserId ? "message_sent" : "message_received")
                    return <div className={mClassName}><div>
                        {message.body} (from {message.from_user.first_name} to {message.to_user.first_name})
                      </div>
                    </div>
                  })
  }
                </div>
                <form onSubmit={this.submitNewMessage}>
                  <input ref="input" type="text" onChange={this.handleMessageChange}/>
                  <input value="Submit" type="submit"/>
                </form>

          </Modal>
          </div>
      </div>
    )
  }
})

export default MessengerWindow