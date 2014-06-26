(function() {
  var main;

  main = function() {
    var button, change_state;
    button = document.querySelectorAll(".btn");
    change_state = function() {
      return console.log("click");
    };
    return button.addEventListener("click", change_state);
  };

  document.addEventListener("DOMContentLoaded", main);

}).call(this);
