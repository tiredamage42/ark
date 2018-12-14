class Message < ApplicationRecord
  belongs_to :conversation
  
  belongs_to :user


  validates :body, presence: true



  #after a message is created, use background job to 
  #return an HTML code and pass it to the 
  #front-end via web-sockets.

  # executes a code or a method passed in params 
  # when a record has been created and successfully inserted to a 
  # database – when SQL commit is done
  
  after_create_commit { MessageBroadcastJob.perform_later(self) }
  #after_create_commit :broadcast_message

  private

  def broadcast_message
    #self in this case points to the created message. 
    #Using the background job here is convenient because later you may extend it and, 
    #for example, send notification emails to the users saying that there is a 
    #new message waiting for them.
    MessageBroadcastJob.perform_later(self)
  end

end

