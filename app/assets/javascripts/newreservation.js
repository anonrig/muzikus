$(document).ready(function(){

	$('.roomselector').change(function() {

	  var id =  $(this).find("option:selected").attr('value');
	  console.log(id);

	  var address = $('#address');
	  var phone = $('#phone');
	  var email = $('#email');
	  if (id == 1){ //davul odasi
	  	address.empty();
	  	phone.empty();
	  	email.empty();

	  	address.append('Kaan KARA');
	  	phone.append('0534 872 8072');
	  	email.append('kaankara@sabanciuniv.edu');
	  } else if (id == 2){ //studyo
	  	address.empty();
	  	phone.empty();
	  	email.empty();

	  	address.append('Yagiz ANDAC, Cagri KARAOGLU');
	  	phone.append('0537 222 7192, 0553 354 9171');
	  	email.append('yagizandac@sabanciuniv.edu, hkaraoglu@sabanciuniv.edu');
	  } else if (id == 3){ // piyano odasi 1
	  	address.empty();
	  	phone.empty();
	  	email.empty();

	  	address.append('Sinem BAYRAKTAR');
	  	phone.append('0536 384 6791');
	  	email.append('sinemb@sabanciuniv.edu');
	  } else if (id == 4){ // piyano odasi 2
	  	address.empty();
	  	phone.empty();
	  	email.empty();

	  	address.append('Iskender YALCINKAYA');
	  	phone.append('0542 242 0520');
	  	email.append('iyalcinkaya@sabanciuniv.edu');
	  } else if (id == 5){ // san odasi
 		address.empty();
	  	phone.empty();
	  	email.empty();

	  	address.append('Meryem Sena BICER');
	  	phone.append('0536 814 2044');
	  	email.append('meryemsenab@sabanciuniv.edu');
	  } else { //hangar
	  	address.empty();
	  	phone.empty();
	  	email.empty();

	  	address.append('Jankat YILMAZ');
	  	phone.append('0533 431 3445');
	  	email.append('jankaty@sabanciuniv.edu');
	  }
	});

	$('#submitreservation').on('click', function(event){
		event.preventDefault();
		$('#contactError').addClass('hidden').empty().append("<strong>Oh snap!</strong> ");
		$('#contactSuccess').addClass('hidden').empty().append("<strong>Success!</strong> ");
		
		var f = $(this).parent().parent();

		var whichDay = $('#whichday').find("option:selected").attr('value');;
		var startHour = $('#starthour').find("option:selected").text();
		var hourCount = $('#hourcount').find("option:selected").attr('value');;

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