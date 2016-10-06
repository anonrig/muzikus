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
    address.append('Burak Aksar');
    phone.append('0507 310 2235');
    email.append('burakaksar@sabanciuniv.edu');
} else if (id == 2){ //studyo
    address.append('Erkin Alacamli, Orhun Baris');
    phone.append('0535 0535 41 73 , 0532 345 5468');
    email.append('erkinalacamli@sabanciuniv.edu, orhunbaris@sabanciuniv.edu');
} else if (id == 3){ // piyano odasi 1
    address.append('Ege Sarac');
    phone.append('0543 978 0607');
    email.append('esarac@sabanciuniv.edu');
} 
 
else if (id == 5){ // san odasi
    address.append('Rabia Tuncbilek');
    phone.append('0537 311 5401');
    email.append('rabiatuncbilek@sabanciuniv.edu');
} else { //hangar
    address.append('Kartal Batuhan Ucar, Kenan Akpınar');
    phone.append('0537 598 9192 , 0506 113 1912 ');
    email.append('kartalucar@sabanciuniv.edu', 'kenanakpınar@sabanciuniv.edu');
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
