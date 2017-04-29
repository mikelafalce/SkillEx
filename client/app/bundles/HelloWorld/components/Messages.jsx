import React from "react";
import ReactDOM from 'react-dom';
import Modal, {closeStyle} from 'simple-react-modal'

var MessengerWindow = React.createClass({
  getInitialState: function() {
     return {
       messages: [],
       messagesById: [],
       convo: false,
       chatId: null
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

  handleClick: function () {
    this.setState({})
  },

  show: function (){
    this.setState({show: true})
  },

  showHandleClick: function (e){
    this.handleClick();
    this.show();
    console.log(e.target.getAttribute('id'))
    const messagesById = this.state.messages[e.target.getAttribute('id')];
    console.log(messagesById);
    this.setState({messagesById: messagesById})
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
                <a onClick={this.close.bind(this)}>Close this modal</a>
                {
                  //Object.keys(userMessages).map(function(userId) {
                  //const messagesForUser = userMessages[userId]
                  this.state.messagesById.map(function(message) {  
                    return <div>{message.body} from {message.from_user.first_name} to {message.to_user.first_name}</div>
                  })
                //})
  }
                </div>
           
          </Modal>
      </div>
    )
  }
})

export default MessengerWindow