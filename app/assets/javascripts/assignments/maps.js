
/**
 * Controlador del Map
 */
App26.MapController= function() {
  this.firstSeatLabel = 1;
  this.sc = null;
  this.width_by_row = 32;
};


/**
 * Funcion que inicializa los eventos del map
 */
App26.MapController.prototype.init = function() {
  if($("#seat_map").length > 0) {
    App26.map.load_map();
  }

}

App26.MapController.prototype.getRawMap = function (number, y, x) {
  var number_arr = number.split(",");
  var map = []
    var i,
      j,
      q;
    var row = "";
    var cell;
    for (i = 1, q = 0; i <= y, q < y; i++, q++) {
      for (j = 1; j <= x; j++) {
        cell = i + "_" + j;
        row += number_arr.indexOf(cell) == -1
          ? "_"
          : "f";
      }
      map[q] = row;
      row = "";
    }
    return map;
}
/**
 * Ejecucion cuando se realiza envio de formulario
 */
App26.MapController.prototype.load_map = function(e) {
  //$('#wrapper').html('<div id="seat_map"></div>');
  var selected_seat = $('#seat_map').data("selected_seat");
  var map = $('#seat_map').data("map");
  var rawMap = App26.map.getRawMap(map.seats, parseInt(map.height, 10), parseInt(map.width, 10));
  App26.map.sc = $('#seat_map').seatCharts({
    map: rawMap,
    seats: {
      f: {
        classes: 'first-class'
      }
    },
    naming: {
      top: false,
      getLabel: function (character, row, column) {
        return App26.map.firstSeatLabel++;
      }
    },
    click: function () {
      if (this.status() == 'available') {
        return  App26.map.sc.find('selected').length == 1 ? 'available' : 'selected';
        return 'available';
      } else if (this.status() == 'selected') {
        if(selected_seat != null) {
          return 'selected';
        } else {
          return 'available';
        }
      } else if (this.status() == 'unavailable') {
        return 'unavailable';
      } else {
        return this.style();
      }
    },
    focus: function () {
      if (this.style() == 'unavailable') {
        this.status('unavailable');
      }

      if (this.status() == 'available') {
        return 'focused';
      } else  {
        return this.style();
      }
    }
  });

  App26.map.set_width_row(map.width);

  var available_seats = $('#seat_map').data("available_seats");
  var unavailable_seats = $('#seat_map').data("unavailable_seats");

  App26.map.setTag(available_seats, 'available');
  App26.map.setTag(unavailable_seats, 'unavailable');
  if(selected_seat != null) {
    App26.map.setTag([selected_seat], 'selected');
  }

  //$('div.seatCharts-cell').css("width", "35px");
/*
  var canvas = document.getElementById("project_canvas");
  context = canvas.getContext('2d');
  var base_image = new Image();
  base_image.src = '/assets/plano-oficina.jpg';
  base_image.onload = function(){
    context.drawImage(base_image, 0, 0);
  }*/
}

App26.MapController.prototype.setTag = function (seats, classname) {
  for (var i = 0; i < seats.length; i++) {
    var html_id = seats[i]["html_id"];
    var code = seats[i]["code"];
    var seat_id = seats[i]["id"];
    var html_id_jq = '#' + html_id;
    $(html_id_jq).attr("title", code);
    $(html_id_jq).html(code).removeClass('available').removeClass('unavailable');
    $(html_id_jq).attr("seat_id", seat_id);
    $(html_id_jq).addClass(classname);
    App26.map.sc.get(html_id).status(classname)
    //TODO FIXED
  }
}

App26.MapController.prototype.set_width_row = function (columns) {
  //var map_width = (parseInt(columns, 10) + 1) * App26.map.width_by_row;
  //$(".seatCharts-row").css("width", map_width + "px");
}


/**
 * Funcion que inicializa el controlador del index
 */
$(function() {
    App26.map = new App26.MapController();
    App26.map.init();
});
