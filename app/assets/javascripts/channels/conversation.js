
    
    
    //instance of a conversations channel.rb
    App.conversation = App.cable.subscriptions.create("ConversationChannel", {
      connected: function() {

        console.log("conected in client channel");
      
        // Called when the subscription is ready for use on the server
      },
    
      disconnected: function() {
        console.log("disconnected in client channel");
      
        // Called when the subscription has been terminated by the server
      },
    
      received: function(data) {
        console.log("received message in client channel");

        console.log("data");
        console.log(data);
      
        // Called when there's incoming data on the websocket for this channel
        // performed when we want to render a partial from the back-end.
        console.log(data['message']);

        //The code looks similar to the conversations/create.js.erb file. 
        //We also search for a specified conversation, based on passed conversation_id, 
        var conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");
        
        //check if under the data[‘window’] we pass a partial. 
        
        if (data['window'] !== undefined) {
          //If yes, it means that  something should be rendered for a recipient. 
          
          
          //We need to check if a conversation’s window is visible
          var conversation_visible = conversation.is(':visible');
          
          if (conversation_visible) {
            
            
            //whether it’s opened or minimized. 
            var messages_visible = (conversation).find('.card-body').is(':visible');
            
            if (!messages_visible) {
              //if messages minimized mark that we got a new message by marking a window as green
              conversation.removeClass('card-primary').addClass('card-success');
            }
            //appending a message partial to the window. 
            conversation.find('.messages-list').find('ul').append(data['message']);
          }
          else {
            //If it’s not visible on the front end, 
            //it means that we should append a whole conversation window partial to the conversations list.
          
            $('#conversations-list').append(data['window']);
            conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");
            conversation.find('.card-body').toggle();
          }
        }
        else {
          //If it’s empty, it means that we should render a code (a message) for a sender.
        
          conversation.find('ul').append(data['message']);
        }

        


        
        //and appended a HTML code within a message to a conversation window 
        //conversation.find('.messages-list').find('ul').append(data['message']);
        
        //and scroll to the bottom of it.
        var messages_list = conversation.find('.messages-list');
        var height = messages_list[0].scrollHeight;
        messages_list.scrollTop(height);
      },




    
      //receives the body of the message 
      //and forwards it to the server 
      //where it will be stored to the database. 
      
      //Note that this method will not output anything 
      //to the page—it should happen inside the 
      //received callback.
      
      //The send_message method calls send_message method on the back-end.
      //sending an object which includes a passed parameter, for example: { message: “Our message” }.
      send_message: function(message) {

        /*
        message:
        [
          {name: "conversation_id", value: "2"}, 
          {name: "user_id", value: "1"}, 
          {name: "body", value: "well wl↵"}
        ] 
        
        */

        console.log("running send message in client channel message:");

        console.log(message);

        console.log("this here is: ");
        console.log(this);
      
        return this.perform('send_message', { message: message });
      }
    });


    //serializes form’s values, runs the send_message method, and resets its values
    //on submit


    console.log("adding callback to submit");

    $(document).on('submit', '.new_message', function(e) {
      e.preventDefault();

    
      console.log("serializing values on:");
      console.log($(this));

      var values = $(this).serializeArray();
      
      console.log("serializing values done:");
      console.log(values);

      console.log("running send message");
      App.conversation.send_message(values);

      console.log("triggering reset on:");
      console.log($(this));

      $(this).trigger('reset');
    });


    
