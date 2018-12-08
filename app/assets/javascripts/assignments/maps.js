
/**
 * Controlador del Home
 */
App26.MapController= function() {
  this.firstSeatLabel = 1;
};


/**
 * Funcion que inicializa los eventos del home
 */
App26.MapController.prototype.init = function() {
  if($("#seat_map").length > 0) {
    App26.map.load_map();
  }

}

App26.MapController.prototype.getRawMap = function (number, y, x) {
  var number_arr = number.split(",");
  var map = [y]
    var i,
      j;
    var row = "";
    var cell;
    for (i = 0; i < y; i++) {
      for (j = 0; j < x; j++) {
        cell = i + "_" + j;
        row += number_arr.indexOf(cell) == -1
          ? "_"
          : "f";
      }
      map[i] = row;
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
  var sc = $('#seat_map').seatCharts({
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
        return  sc.find('selected').length == 1 ? 'available' : 'selected';
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
    }
  });
  var available_seats = $('#seat_map').data("available_seats");
  var unavailable_seats = $('#seat_map').data("unavailable_seats");

  App26.map.setTag(available_seats, 'available');
  App26.map.setTag(unavailable_seats, 'unavailable');
  if(selected_seat != null) {
    App26.map.setTag([selected_seat], 'selected');
  }
}

App26.MapController.prototype.setTag = function (seats, classname) {
  for (var i = 0; i < seats.length; i++) {
    var html_id = seats[i]["html_id"];
    var code = seats[i]["code"];
    var seat_id = seats[i]["id"];
    var html_id_jq = '#' + html_id;
    $(html_id_jq).html(code).css("width", "50px").css("color", "black").css("font-weight", "bolder").removeClass('available').removeClass('unavailable');
    $(html_id_jq).attr("seat_id", seat_id);
    $(html_id_jq).addClass(classname);
    if(classname == "selected") {
      $(html_id_jq).click();
      $(html_id_jq).attr("aria-checked", true);
    }
    //TODO FIXED
  }
}


/**
 * Funcion que inicializa el controlador del index
 */
$(function() {
    App26.map = new App26.MapController();
    App26.map.init();
});
