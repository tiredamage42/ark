
# A job is a class which performs code 
# by using Redis server and is not connected with a Rails server. 
# It can create or update a record, call a model’s method

class MessageBroadcastJob < ApplicationJob
  queue_as :default
  
  # Do something later
  def perform(message)
    #We pass there a message object, 
    #so we can easily get two users to whom a HTML code should be sent to. 

    sender = message.user
    recipient = message.conversation.opposed_user(sender)

    broadcast_to_sender(sender, message)
    broadcast_to_recipient(recipient, message)

    #logger.info "Processing the request..."
  end

  #def perform(message)
  #  payload = {
  #    room_id: message.conversation.id,
  #    content: message.content,
  #    sender: message.sender,
  #    participants: message.conversation.users.collect(&:id)
  #  }
  #  ActionCable.server.broadcast("ChatRoom-#{message.conversation.id}", payload)
  #end
  

  private
  
  #Inside the perform action we broadcast the message rendered by the ApplicationController
  #connect with specified channel and send 
  #a conversation_id and HTML code using a partial. 

  #in Rails 5 we can render HTML code from any partial or a view 
  #by calling the ApplicationController.render method outside a controller.


  def broadcast_to_sender(user, message)
    ActionCable.server.broadcast(
      "conversations-#{user.id}",
      message: render_message(message, user),
      conversation_id: message.conversation_id
    )
  end

  def broadcast_to_recipient(user, message)
    ActionCable.server.broadcast(
      "conversations-#{user.id}",
      window: render_window(message.conversation, user),
      message: render_message(message, user),
      conversation_id: message.conversation_id
    )
  end


  def render_message(message, user)
    ApplicationController.render(
      partial: 'messages/message',
      locals: { message: message, user: user }
    )
  end

  def render_window(conversation, user)
    ApplicationController.render(
      partial: 'conversations/conversation',
      locals: { conversation: conversation, user: user }
    )
  end

end



