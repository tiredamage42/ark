#SERVER SIDE

class ConversationChannel < ApplicationCable::Channel
  # Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
 
  
  # Using the subscribed method adds us to a channel. 
  # While you’re subscribed to the channel, 
  # code performed in a certain channel will be sent to users that are connected in the channel.

  # only a group of people will get 
  # the results of the method. on the front-end. 
  # subscribe to channel on entering certain page

  def subscribed
    # stream_from "some_channel"

    # We want to create a unique channel for each user.

    #the sender and recipient will receive different information, 
    #so we’ll always need to notify two channels after performing code.


    #maybe jsut conversation id
    stream_from "conversations-#{current_user.id}"
  end
  
  # Unsubscribed method removes us from certain channel or from all channels.
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end
  
  #called when client broadcasts data
  # can do almost everything. Creates a record and later renders a part of view, sends an email or logs something.
  def send_message(data)

    #this is called by js script client side

    #The data local variable contains a hash 
    #so we can access the message's body quite 
    #easily to save it to the database:

    
    message_params = data['message'].each_with_object({}) do |el, hash|
      hash[el.values.first] = el.values.last
    end
    
    #creates a message based on passed params, 
    #after message is saved to database it broadcasts itself to clients
    #(receive method on conversation js)
    
    Message.create(message_params)
    
    
    #or
    #current_user.messages.create(body: data['message'])
    
    #builds a hash that’s based on a passed data 
    # and sends data to the front-end using the ActionCable.server.broadcast 
    # method to the specified channel. 
    # Data sent from this method is visible in the received method on the front-end.
    #ActionCable.server.broadcast(
    #  "conversations-#{current_user.id}",
    #  message: message_params
    #)



    #or (from medium tut)

    #sender    = get_sender(data)
    #room_id   = data['room_id']
    #message   = data['message']

    #raise 'No room_id!' if room_id.blank?
    #convo = get_convo(room_id) # A conversation is a room
    #raise 'No conversation found!' if convo.blank?
    #raise 'No message!' if message.blank?

    # adds the message sender to the conversation if not already included
    #convo.users << sender unless convo.users.include?(sender)
    # saves the message and its data to the DB
    #Message.create!(
    #  conversation: convo,
    #  sender: sender,
    #  content: message
    #)
  end

  # Helpers
  
  #def get_convo(room_code)
  #  Conversation.find_by(room_code: room_code)
  #end
    
  #def set_sender
  #  User.find_by(guid: id)
  #end
end


