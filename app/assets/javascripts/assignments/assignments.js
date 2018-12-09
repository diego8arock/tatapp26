//= require jquery3
//= require jquery_ujs
//= require bootstrap
//= require app26
//= require assignments/maps
/**
 * Controlador del assignment
 */
App26.AssignmentController= function() {
};


/**
 * Funcion que inicializa los eventos del home
 */
App26.AssignmentController.prototype.init = function() {
  $('#error_message').addClass("hidden");
  if($("#countdownSelect").length > 0) {
    var timeleft = App26.timeToSelect;
    $("#countdownSelect").text(timeleft);
    var downloadTimer = setInterval(function(){
      timeleft--;
      $("#countdownSelect").text(timeleft);
      if(timeleft <= 0){
        clearInterval(downloadTimer);
        App26.assignment.randomSelect();
      }
    },1000);
  }

  //Modal confirma asignacion
  $('body').on('hidden.bs.modal', '#confirm_select_modal', function() {
    document.location.href = '/users/sign_out';
  });

  $('body').on('hidden.bs.modal', '#confirm_cancel_modal', function() {
    document.location.href = '/users/sign_out';
  });

  $('#confirm_cancel_modal').on('click', '#continue_btn', function() {
    document.location.href = '/assignments/new';
  });

  $('body').on('click', '#create_assignment', App26.assignment.createAssignment);
  $('body').on('click', '#cancel_assignment', App26.assignment.cancelAssignment);

  $("#office").elevateZoom({
            zoomWindowWidth:700,
            zoomWindowHeight:700});
}

/**
 * TODO: Ejecucion cuando se acaba el tiempo para seleccionar asiento
 */
App26.AssignmentController.prototype.randomSelect = function() {
  var available_seats = $('#seat_map').data("available_seats");
  var random = -1;
  while (random < 0) {
    random = Math.floor(Math.random() * available_seats.length);
  }
  $('#seat_id').val(available_seats[random]["id"]);
  var selected_seats = [ available_seats[random]];
  App26.map.setTag(selected_seats, 'selected');
  App26.assignment.createAssignment(null);
  return false;
}

/**
 * Create assignment
 */
App26.AssignmentController.prototype.createAssignment = function(event) {
  if(event != null){
    event.preventDefault();
  }

  if($(".selected").length > 0) {
    $('#seat_id').val($(".selected").eq(0).attr("seat_id"));
    $.ajax({
      url: "/assignments.json",
      data: $("#assignment_form").serialize(),
      dataType: 'json',
      type: 'post',
      success: function(data) {
        $("#selected_seat").text(data.seat.code);
        $("#confirm_select_modal").modal('show');
      },
      error: function(jqXHR, textStatus, errorThrown){
        $("#alert").text(errorThrown) ;
      }
    });
  } else {
    $('#error_message').removeClass("hidden");
    $('#error_message_txt').text("Please select one seat to continue");
  }
  return false;
}

/**
 * Ejecucion cuando se acaba el tiempo para seleccionar asiento
 */
App26.AssignmentController.prototype.cancelAssignment = function(e) {
  e.preventDefault();
  $.ajax({
    url: "/assignment/" +  $('#assignment_id').val() + "/cancel.json",
    dataType: 'json',
    type: 'post',
    success: function(data) {
      $("#canceled_seat").text(data.seat.code);
      $("#confirm_cancel_modal").modal('show');
    },
    error: function(jqXHR, textStatus, errorThrown){
      $("#alert").text(errorThrown) ;
    }
  });
  return false;
}


/**
 * Funcion que inicializa el controlador del index
 */
$(function() {
    App26.assignment = new App26.AssignmentController();
    App26.assignment.init();
});
