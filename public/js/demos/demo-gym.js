/*
Name: 			Gym
Written by: 	Okler Themes - (http://www.okler.net)
Theme Version:	5.7.2
*/

(function( $ ) {

	'use strict';
	
	// Slider Options
	var sliderOptions = {
		sliderType: 'standard',
		sliderLayout: 'fullscreen',
		responsiveLevels: [4096,1200,992,420],
		gridwidth:[1170,970,750],
		delay: 5000,
		disableProgressBar: 'on',
		lazyType: "none",
		shadow: 0,
		spinner: "off",
		shuffle: "off",
		autoHeight: "off",
		fullScreenAlignForce: "off",
		fullScreenOffset: "",
		hideThumbsOnMobile: "off",
		hideSliderAtLimit: 0,
		hideCaptionAtLimit: 0,
		hideAllCaptionAtLilmit: 0,
		debugMode: false,
		fallbacks: {
			simplifyAll: "off",
			nextSlideOnWindowFocus: "off",
			disableFocusListener: false,
		},
		navigation: {
			keyboardNavigation: "on",
			keyboard_direction: "horizontal",
			mouseScrollNavigation: "off",
			onHoverStop: "off",
			touch: {
				touchenabled: "on",
				swipe_threshold: 75,
				swipe_min_touches: 1,
				swipe_direction: "horizontal",
				drag_block_vertical: false
			},
			arrows: {
				enable: false,
			},
			bullets: {
				style:"custom-tp-bullets",
		        enable: true,
		        container:"slider",
		        rtl: false,
		        hide_onmobile: false,
		        hide_onleave: true,
		        hide_delay: 200,
		        hide_delay_mobile: 1200,
		        hide_under: 0,
		        hide_over: 9999,
		        direction:"horizontal",
		        space: 20,       
		        h_align: "center",
		        v_align: "bottom",
		        h_offset: 0,
		        v_offset: 50
			}
		},
		parallax:{
			type:"on",
			levels:[20,40,60,80,100],
			origo:"enterpoint",
			speed:400,
			bgparallax:"on",
			disable_onmobile:"off"
		}
	}
		
	// Slider Init
	$('#revolutionSlider').revolution(sliderOptions);

	// Instagram Feed
	var feed = new Instafeed({
        get: 'user',
        userId: 'self',
        clientId: '11111111111111111111111111111111',
        accessToken: '1111111111.1111111.11111111111111111111111111111111',
        resolution: 'standard_resolution',
        template: '<div style="background: url({{image}}); background-size: cover;"><a target="_blank" href="{{link}}"></a></div>',
        after: function(){
        	// Init Owl Carousel Instagram
			$('.owl-instagram').owlCarousel({
				items: 2,
				nav: false,
				dots: false,
				loop: true,
				navText: [],
				autoplay: true,
				autoplayTimeout: 6000
			});
        }
    });

    // Init Instafeed
    if( $('#instafeed').get(0) ) {
    	feed.run();
    }

    // Custom Menu Style
    if($('.custom-header-style-1').get(0)) {
    	$('.header-nav-main nav > ul > li > a').each(function(){
	    	var parent = $(this).parent(),
	    		clone  = $(this).clone(),
	    		clone2 = $(this).clone(),
	    		wrapper = $('<span class="wrapper-items-cloned"></span>');

	    	// Config Classes
	    	$(this).addClass('item-original');
	    	clone2.addClass('item-two');

	    	// Insert on DOM
	    	parent.prepend(wrapper);
	    	wrapper.append(clone).append(clone2);
	    });
    }

    // Isotope
    var $wrapper = $('#itemDetailGallery');

	if( $wrapper.get(0) ) {
		$wrapper.waitForImages(function() {
			$wrapper.isotope({
				itemSelector: '.isotope-item'
			});
		});
	}

	/*
	VIP Request Form
	*/
	$('#vipRequest').validate({
		submitHandler: function(form) {

			var $form = $(form),
				$messageSuccess = $('#vipRequestSuccess'),
				$messageError = $('#vipRequestError'),
				$submitButton = $(this.submitButton),
				$errorMessage = $('#vipRequestErrorMessage');

			$submitButton.button('loading');

			// Ajax Submit
			$.ajax({
				type: 'POST',
				url: $form.attr('action'),
				data: {
					name: $form.find('#vipRequestName').val(),
					email: 'you@domain.com',
					subject: 'Gym - VIP Request',
					message: 'Name' + $form.find('#vipRequestName').val() + '<br>E-mail:' + $form.find('#vipRequestEmail').val() + '<br>Phone:' + $form.find('#vipRequestPhone').val()
				}
			}).always(function(data, textStatus, jqXHR) {

				$errorMessage.empty().hide();

				if (data.response == 'success') {

					$messageSuccess.removeClass('hidden');
					$messageError.addClass('hidden');

					// Reset Form
					$form.find('.form-control')
						.val('')
						.blur()
						.parent()
						.removeClass('has-success')
						.removeClass('has-error')
						.find('label.error')
						.remove();

					if (($messageSuccess.offset().top - 80) < $(window).scrollTop()) {
						$('html, body').animate({
							scrollTop: $messageSuccess.offset().top - 80
						}, 300);
					}

					$submitButton.button('reset');
					
					return;

				} else if (data.response == 'error' && typeof data.errorMessage !== 'undefined') {
					$errorMessage.html(data.errorMessage).show();
				} else {
					$errorMessage.html(data.responseText).show();
				}

				$messageError.removeClass('hidden');
				$messageSuccess.addClass('hidden');

				if (($messageError.offset().top - 80) < $(window).scrollTop()) {
					$('html, body').animate({
						scrollTop: $messageError.offset().top - 80
					}, 300);
				}

				$form.find('.has-success')
					.removeClass('has-success');
					
				$submitButton.button('reset');

			});
		}
	});

	/*
	Contact Form Message
	*/
	$('#contactFormMessage').validate({
		submitHandler: function(form) {

			var $form = $(form),
				$messageSuccess = $('#contactFormMessageSuccess'),
				$messageError = $('#contactFormMessageError'),
				$submitButton = $(this.submitButton),
				$errorMessage = $('#contactFormMessageErrorMessage');

			$submitButton.button('loading');

			// Ajax Submit
			$.ajax({
				type: 'POST',
				url: $form.attr('action'),
				data: {
					name: $form.find('#contactName').val(),
					email: 'you@domain.com',
					subject: 'Gym - Contact Message',
					message: 'Name' + $form.find('#contactName').val() + '<br>E-mail:' + $form.find('#contactEmail').val() + '<br>Phone:' + $form.find('#contactPhone').val() + '<br>Message:' + $form.find('#contactMessage').val()
				}
			}).always(function(data, textStatus, jqXHR) {

				$errorMessage.empty().hide();

				if (data.response == 'success') {

					$messageSuccess.removeClass('hidden');
					$messageError.addClass('hidden');

					// Reset Form
					$form.find('.form-control')
						.val('')
						.blur()
						.parent()
						.removeClass('has-success')
						.removeClass('has-error')
						.find('label.error')
						.remove();

					if (($messageSuccess.offset().top - 80) < $(window).scrollTop()) {
						$('html, body').animate({
							scrollTop: $messageSuccess.offset().top - 80
						}, 300);
					}

					$submitButton.button('reset');
					
					return;

				} else if (data.response == 'error' && typeof data.errorMessage !== 'undefined') {
					$errorMessage.html(data.errorMessage).show();
				} else {
					$errorMessage.html(data.responseText).show();
				}

				$messageError.removeClass('hidden');
				$messageSuccess.addClass('hidden');

				if (($messageError.offset().top - 80) < $(window).scrollTop()) {
					$('html, body').animate({
						scrollTop: $messageError.offset().top - 80
					}, 300);
				}

				$form.find('.has-success')
					.removeClass('has-success');
					
				$submitButton.button('reset');

			});
		}
	});
    
}).apply( this, [ jQuery ]);