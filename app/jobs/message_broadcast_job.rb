class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "messages_#{message.to_user_id}",
                                 message: message
  end
end
