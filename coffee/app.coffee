button = null

main = ->

  button = document.querySelector "button"

  fun = (data) ->
    console.log data
    console.log "OK"

  notify_arduino = ->
    url = "/"
    httpRequest = new XMLHttpRequest()
    httpRequest.addEventListener "onreadystatechange", fun

    httpRequest.open('POST', url)
    httpRequest.send()

  change_state = ->
    if button.innerHTML == "OFF"
      button.innerHTML = "ON"
    else
      button.innerHTML = "OFF"

    notify_arduino()

  button.addEventListener "click", change_state







document.addEventListener "DOMContentLoaded", main


#######