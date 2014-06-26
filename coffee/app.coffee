button = null

main = ->

  button = document.querySelectorAll "div"

  change_state = ->
    console.log "click"


  button.addEventListener "click", change_state


document.addEventListener "DOMContentLoaded", main


#######