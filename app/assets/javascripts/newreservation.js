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
    address.append('Berkin Özbatir');
    phone.append('0534 357 6588');
    email.append('berkinozbatir@sabanciuniv.edu');
} else if (id == 2){ //studyo
    address.append('Kartal Batuhan Ucar, Ege Sarac');
    phone.append('0537 598 9192, 0543 978 0607');
    email.append('kartalucar@sabanciuniv.edu, esarac@sabanciuniv.edu');
} else if (id == 3){ // piyano odasi 1
    address.append('Sevval Calis');
    phone.append('0534 438 1116');
    email.append('calissevval@sabanciuniv.edu');
} else if (id == 4){ // piyano odasi 2
    address.append('Iskender Yalcinkaya');
    phone.append('0542 242 0520');
    email.append('iyalcinkaya@sabanciuniv.edu');
} else if (id == 5){ // san odasi
    address.append('Isinsu Tastan');
    phone.append('0554 776 7718');
    email.append('tastanisinsu@sabanciuniv.edu');
} else { //hangar
    address.append('Berk Can Altindag');
    phone.append('0535 221 6994');
    email.append('acan@sabanciuniv.edu');
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
