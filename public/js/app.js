var button, main;

button = null;

main = function() {
  var change_state, fun, notify_arduino;
  button = document.querySelector("button");
  fun = function(data) {
    console.log(data);
    return console.log("OK");
  };
  notify_arduino = function() {
    var httpRequest, url;
    url = "/";
    httpRequest = new XMLHttpRequest();
    httpRequest.addEventListener("onreadystatechange", fun);
    httpRequest.open('POST', url);
    return httpRequest.send();
  };
  change_state = function() {
    if (button.innerHTML === "OFF") {
      button.innerHTML = "ON";
    } else {
      button.innerHTML = "OFF";
    }
    return notify_arduino();
  };
  return button.addEventListener("click", change_state);
};

document.addEventListener("DOMContentLoaded", main);
