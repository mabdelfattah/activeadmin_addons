var initializer = function() {
  var tel_inputs = document.querySelector(".tel-input");
  window.intlTelInput(tel_inputs, {
    utilsScript: '/assets/intlTelInput_utils.js',
    separateDialCode: true
  });
};

$(initializer);
$(document).on('turbolinks:load', initializer);
