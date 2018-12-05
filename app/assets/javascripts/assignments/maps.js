
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
  if($("#seat-map").length > 0) {
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
  //$('#wrapper').html('<div id="seat-map"></div>');
  var map = $('#seat-map').data("map");
  var rawMap = App26.map.getRawMap(map.seats, parseInt(map.height, 10), parseInt(map.width, 10));
  var sc = $('#seat-map').seatCharts({
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
        return 'available';
      } else if (this.status() == 'unavailable') {
        return 'unavailable';
      } else {
        return this.style();
      }
    }
  });
}


/**
 * Funcion que inicializa el controlador del index
 */
$(function() {
    App26.map = new App26.MapController();
    App26.map.init();
});
