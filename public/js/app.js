var button, main;

button = null;

main = function() {
  var change_state;
  button = document.querySelectorAll("div");
  change_state = function() {
    return console.log("click");
  };
  return button.addEventListener("click", change_state);
};

document.addEventListener("DOMContentLoaded", main);
