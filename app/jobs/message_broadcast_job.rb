class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "messages_#{message.to_user_id}",
                                 message: message.as_json(include: [:from_user, :to_user])
    ActionCable.server.broadcast "messages_#{message.from_user_id}",
                                 message: message.as_json(include: [:from_user, :to_user])

  end
end
