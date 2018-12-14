// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require activestorage
//= require_tree .

/*
runs a jQuery toggle() method and scrolls to the bottom of the window if it’s visible.
*/


$(document).on(
    'click', 
    '.toggle-chat-window', 
    function(e) {

        e.preventDefault();

        console.log(e);
  
        var card = $(this).parent().parent();
        console.log(card);
  
        
        card.find('.card-body').toggle();
        console.log(card);
        
        card.attr('class', 'card card-primary');
        console.log(card);
        
        if (card.find('.card-body').is(':visible')) {
            
            console.log("we're visible");
            
            var messages_list = card.find('.messages-list');
            var height = messages_list[0].scrollHeight;
            messages_list.scrollTop(height);



        }
    }     
);

(function() {
})();
    
