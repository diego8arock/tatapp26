function initInputs(inputName) {
    $('input[type=text], input[type=password], input[type=email], input[type=url], input[type=tel], input[type=number], input[type=search], input[type=date], input[type=time], textarea').each(function(element, i) {
        if (this.id == inputName){
            if ((element.value == "")) {
                $(this).siblings('label').removeClass('active')
            } else {
                $(this).siblings('label').addClass('active')
            }
        }
    })
}

function hideInputs(inputName) {
    $('input[type=text], input[type=password], input[type=email], input[type=url], input[type=tel], input[type=number], input[type=search], input[type=date], input[type=time], textarea').each(function(element, i) {
        if (this.id == inputName){
            $(this).siblings('label').removeClass('active')
        }
    })
}

function showLabels(inputName) {
    $('input[type=text], input[type=password], input[type=email], input[type=url], input[type=tel], input[type=number], input[type=search], input[type=date], input[type=time], textarea').each(function(element, i) {
        if (this.id == inputName){
            $(this).siblings('label').addClass('active')
        }
    })
}

function toggleIcons(icon, baseClass, alternateClass) {
    console.log("toggleIcons is invoked for = ", icon);
    icon.className = alternateClass;
//    icon.toggleClass(alternateClass)
//      .toggleClass(baseClass);
}

// Material Select Initialization
function showList(){
    $('.mdb-select').materialSelect();
}