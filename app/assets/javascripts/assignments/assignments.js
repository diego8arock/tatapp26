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
    document.location.href = '/logout';
  });

  $('body').on('hidden.bs.modal', '#confirm_cancel_modal', function() {
    document.location.href = '/logout';
  });

  $('#confirm_cancel_modal').on('click', '#continue_btn', function() {
    document.location.href = '/assignments/new';
  });

  $('body').on('click', '#create_assignment', App26.assignment.createAssignment);
  $('body').on('click', '#cancel_assignment', App26.assignment.cancelAssignment);

}

/**
 * TODO: Ejecucion cuando se acaba el tiempo para seleccionar asiento
 */
App26.AssignmentController.prototype.randomSelect = function() {
  var $options = $('#seat').find('option');
  var random = 0;
  while (random == 0) {
    random = Math.floor(Math.random() * $options.length);
  }

  $options.eq(random).prop('selected', true);
  $('#seat_id').val($('#seat').val());
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
