class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages_#{current_user.id}"

    Message.for_user(current_user).latest(20).find_each do |message|
      MessageBroadcastJob.perform_later(message)
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(to_user_id:, body:)
    message = Message.create!(
      from_user_id: current_user,
      to_user_id: to_user_id,
      body: body
    )

    MessageBroadcastJob.perform_later(message)
  end
end