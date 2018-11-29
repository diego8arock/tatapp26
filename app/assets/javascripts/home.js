
/**
 * Controlador del Home
 */
App26.HomeController= function() {
};


/**
 * Funcion que inicializa los eventos del home
 */
App26.HomeController.prototype.init = function() {
  //login
  $('#login').on('submit', this.findEmployee );

}

/**
 * Ejecucion cuando se realiza envio de formulario
 */
App26.HomeController.prototype.findEmployee = function(e) {
  $.ajax({
    url: "/employees",
    data: $(this).serialize(),
    type: 'post',
    success: function(data) {
      if(data.id != undefined) {
        $('#confirm_data_modal').modal("show");
      }
    },
    error: function(jqXHR, textStatus, errorThrown){
    }
  });
  return false;
}


/**
 * Funcion que inicializa el controlador del index
 */
$(function() {
    App26.index = new App26.HomeController();
    App26.index.init();

    // Calendar
    $('.birthday').datepicker({
      format: 'dd/mm/yyyy',
      weekStart: 1,
      language: 'es',
      autoclose: true
    });
});
