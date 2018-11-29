
/**
 * Controlador del assignment
 */
App26.AssignmentController= function() {
};


/**
 * Funcion que inicializa los eventos del home
 */
App26.AssignmentController.prototype.init = function() {

}

/**
 * Ejecucion cuando se realiza envio de formulario
 */
App26.AssignmentController.prototype.findEmployee = function(e) {
  return false;
}


/**
 * Funcion que inicializa el controlador del index
 */
$(function() {
    App26.index = new App26.AssignmentController();
    App26.index.init();
});
