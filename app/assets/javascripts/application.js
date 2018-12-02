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
//= require activestorage
//= require turbolinks
//= require jquery3
//= require jquery_ujs
//= require_tree .

function textFieldOnlyNumbers(e) {
  if (!(
      // Allow: backspace, tab, enter, esc, end, home, left, right, del, point, period
      $.inArray(e.keyCode, [8, 9, 13, 27, 35, 36, 37, 39, 46, 110, 190]) !== -1 ||
      // Allow: Ctrl+A, Ctrl+C, Ctrl+X
      ((e.ctrlKey || e.metaKey) && $.inArray(e.keyCode, [65, 67, 88]) !== -1) ||
      // Allow: keys 0-9
      (!e.shiftKey && e.keyCode >= 48 && e.keyCode <= 57) ||
      // Allow: numpad 0-9
      (e.keyCode >= 96 && e.keyCode <= 105))) {
    // Disallow: every other keypress
    e.preventDefault();
  }
}

function randomNumberGenerator() {
    var minNumber = 0; // The minimum number you want
    var maxNumber = 100; // The maximum number you want
    var randomnumber = Math.floor(Math.random() * (maxNumber + 1) + minNumber); // Generates random number
    return randomnumber;
}
