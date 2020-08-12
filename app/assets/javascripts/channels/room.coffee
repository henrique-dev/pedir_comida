App.room = App.cable.subscriptions.create "AdminChannel",  
  received: (data) ->
    newOrderReceived(data.message);