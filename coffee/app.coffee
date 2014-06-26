main = ->

  button = document.querySelectorAll ".btn"

  change_state = ->
    console.log "click"



  button.addEventListener "click", change_state


document.addEventListener "DOMContentLoaded", main


#######