$(document).ready(function(){
	$('.roomselector').change(function() {

        var id =  $(this).find("option:selected").attr('value'),
            address = $('#address'),
            phone = $('#phone'),
            email = $('#email');

        address.empty();
        phone.empty();
        email.empty();

        if (id == 1){ //davul odasi
            address.append('Emre BOZKIR');
            phone.append('0536 509 9305');
            email.append('emrebozkir@sabanciuniv.edu');
        } else if (id == 2){ //studyo
            address.append('Ercan USTA, Can ARSOY');
            phone.append('0530 220 2870, 0533 359 2094');
            email.append('ercanusta@sabanciuniv.edu, canarsoy@sabanciuniv.edu');
        } else if (id == 3){ // piyano odasi 1
            address.append('Burcu CIRACI');
            phone.append('0537 877 9461');
            email.append('burcuciraci@sabanciuniv.edu');
        } else if (id == 4){ // piyano odasi 2
            address.append('Iskender YALCINKAYA');
            phone.append('0542 242 0520');
            email.append('iyalcinkaya@sabanciuniv.edu');
        } else if (id == 5){ // san odasi
            address.append('Sinan USTA');
            phone.append('0530 220 2871');
            email.append('sinanusta@sabanciuniv.edu');
        } else { //hangar
            address.append('Mert CAPAN');
            phone.append('0537 351 9650');
            email.append('mertcap@sabanciuniv.edu');
        }
	});

	$('#submitreservation').on('click', function(event){
		event.preventDefault();
		$('#contactError').addClass('hidden').empty().append("<strong>Oh snap!</strong> ");
		$('#contactSuccess').addClass('hidden').empty().append("<strong>Success!</strong> ");
		
		var f = $(this).parent().parent(),
            whichDay = $('#whichday').find("option:selected").attr('value'),
            startHour = $('#starthour').find("option:selected").text(),
            hourCount = $('#hourcount').find("option:selected").attr('value');

		$('this').attr("disabled", true);

		$.ajax({
			type: f.attr("method"),
			url: f.attr("action"),
			data: f.serialize() + '&whichDay=' + whichDay + '&startHour=' + startHour + '&hourCount=' + hourCount,
			dataType: "html",
			complete: function(){
				$('this').attr("disabled", false);
			},
			success: function(msg){
				if (msg == "hourcount"){
					//3 saati astin
					$('#contactError').append("You can't reserve more than 3 hours on the same day, master.");
					$('#contactError').removeClass('hidden');
				} else if (msg == "occupiedreservation"){
					//almak istedigin saatler dolu
					$('#contactError').append("You trying to reserve to an occupied spot, master.");
					$('#contactError').removeClass('hidden');
				} else {
					$('#contactSuccess').removeClass('hidden');
					window.location.href = "/reservations";
				}
			},
			error: function(xhr, status){
				console.log(status);
			}
		});

	});
	
	$('.tooltip-test').tooltip();
});