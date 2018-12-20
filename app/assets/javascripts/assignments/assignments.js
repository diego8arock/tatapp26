//= require jquery3
//= require jquery_ujs
//= require bootstrap
//= require lib/jquery.seat-charts.min
//= require lib/bootstrap-tour-standalone.min
//= require lib/jquery.elevateZoom-3.0.8.min
//= require i18n
//= require i18n/translations
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
  }

  $('#error_message').addClass("hidden");

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
/*
  if($("#office").length > 0) {
    $("#office").elevateZoom({
              zoomWindowWidth:700,
              zoomWindowHeight:700});
  }*/
  //App26.assignment.setProjectImage();

  //Must do tour
  if($("#tour").length > 0) {
    var steps = [
      {
        path: "/generalmap",
        placement: "top",
        element: "#office2",
        title: I18n.t('tour.steps.first.title'),
        content: I18n.t('tour.steps.first.content'),
        backdrop: true,
        backdropPadding: 5
      },
      {
        path: "/assignments/new",
        placement: "top",
        element: "#project_plane",
        title: I18n.t('tour.steps.second.title'),
        content: I18n.t('tour.steps.second.content'),
        backdrop: true,
        backdropPadding: 5
      }
    ];
    if($("#countdownSelect").length > 0) {
      steps[2] =
        {
          path: "/assignments/new",
          placement: "top",
          element: "#seat_map",
          title: I18n.t('tour.steps.third.title'),
          content: I18n.t('tour.steps.third.content'),
          backdrop: true,
          backdropPadding: 5
        }
      steps[3] =
        {
          path: "/assignments/new",
          placement: "top",
          element: "#countdownSelect",
          title: I18n.t('tour.steps.fourth.title'),
          content: I18n.t('tour.steps.fourth.content', {seconds: App26.timeToSelect}),
          backdrop: true,
          backdropPadding: 5
        }
    } else {
      steps[2] =
        {
          path: "/assignments/new",
          placement: "top",
          element: "#seat_map",
          title: I18n.t('tour.steps.fifth.title'),
          content: I18n.t('tour.steps.fifth.content'),
          backdrop: true,
          backdropPadding: 5
        }
      steps[3] =
        {
          path: "/assignments/new",
          placement: "top",
          element: "#fixed",
          title: I18n.t('tour.steps.sixth.title'),
          content: I18n.t('tour.steps.sixth.content'),
          backdrop: true,
          backdropPadding: 5
        }
    }

     // Instance the tour
    var tour = new Tour({
      debug: true,
      steps: steps,
      onEnd: function (tour) {
          App26.assignment.startCoundown();
      }
    });
    // Initialize the tour
    tour.init();

    if($("#tour").data("restart")) {
      // Start the tour
      tour.restart();
    } else{
      // Start the tour
      tour.start();
    }
    if(tour.ended()) {
        App26.assignment.startCoundown();      
    }
  } else {
      App26.assignment.startCoundown();
  }

  $("#project_canvas").css("height",$("#seat_map").css("height"));
  $("#project_canvas").css("width",$("#seat_map").css("width"));
  
}

/**
 * Start the coundown
 */
App26.AssignmentController.prototype.setProjectImage = function() {

  // create a new canvas
  var image = $('#office2');
  var canvas = document.createElement('canvas');
  canvas.style = "position:relative;margin-left:0px;margin-top:0px;";
  canvas.width = image.css("width");
  canvas.height = image.css("height");

          var canvastag = document.getElementById('canvas');
          canvastag.appendChild(canvas);
  var ctx = canvas.getContext('2d');

  ctx.lineWidth = 5;
  ctx.strokeStyle = "#080aa2";

  var imageObj = new Image();

  // Draw  image onto the canvas
  imageObj.onload = function () {
    ctx.drawImage(imageObj, 0, 0);
  };
  imageObj.src = image.attr("src");

  ctx.beginPath();
  ctx.width = image.css("width");
  ctx.height = image.css("height");
  ctx.globalCompositeOperation = 'destination-over';

  //draw project image mofified
  /*ctx.clearRect(0, 0, 1430, 882);
  ctx.globalAlpha = 0.5;
  ctx.fillStyle = 'green';
  ctx.fill();

  ctx.beginPath();
  ctx.globalAlpha = 0.9;
  ctx.arc(370, 440, 6, 0, 2 * Math.PI, false);
  ctx.fillStyle = 'black';
  ctx.fill();*/

  ctx.beginPath();
  ctx.globalAlpha = 0.8;
  ctx.arc(370, 440, 15, 0, 2 * Math.PI, false);
  ctx.fillStyle = 'blue';
  ctx.fill();

  ctx.globalAlpha = 1;

  //text
  ctx.font = 'italic 30pt Calibri';
  ctx.fillText(I18n.t('current_position'), 500, 310);

  //line
  ctx.beginPath();
  ctx.moveTo(385, 425);
  ctx.lineTo(495, 315);
  ctx.lineWidth = 4;

  // set line color
  ctx.strokeStyle = '#ff0000';
  ctx.stroke();

  //Draw image with changes
  ctx.drawImage(imageObj, 0, 0);
  ctx.globalAlpha = 1.00;

}

/**
 * Start the coundown
 */
App26.AssignmentController.prototype.startCoundown = function() {
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
    $('#error_message_txt').text(I18n.t('errors.no_seat'));
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
