import React from 'react';

export default function({conversations, onConversationClick}){
  return <div className="conversations">
  {conversations.map((conversation,index) =>{ 
      const {lastMessage,userId} = conversation;
      return <div key={index}  onClick={onConversationClick.bind(null, conversation )}>
      {lastMessage.body} from {lastMessage.from_user.first_name} to {lastMessage.to_user.first_name}
    </div>})}
  </div>;
}
