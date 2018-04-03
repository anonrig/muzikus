/*
Name: 			Finance
Written by: 	Okler Themes - (http://www.okler.net)
Theme Version:	5.7.2
*/
// Demo Config
(function($) {

	'use strict';

	// Slider Options
	var sliderOptions = {
		sliderType: 'standard',
		sliderLayout: 'fullscreen',
		fullScreenOffsetContainer: '#header, #home-intro',
		delay: 10000,
		responsiveLevels: [4096, 1200, 991, 500],
		gridwidth: [1170, 970, 750],
		gridheight: 650,
		lazyType: "none",
		shadow: 0,
		spinner: "off",
		shuffle: "off",
		autoHeight: "off",
		fullScreenAlignForce: "off",
		fullScreenOffset: "",
		disableProgressBar: "on",
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
			keyboardNavigation: 'off',
			keyboard_direction: 'horizontal',
			mouseScrollNavigation: 'off',
			onHoverStop: 'off',
			touch: {
				touchenabled: 'on',
				swipe_threshold: 75,
				swipe_min_touches: 1,
				swipe_direction: 'horizontal',
				drag_block_vertical: false
			},
			arrows: {
				enable: true,
				hide_onmobile: true,
				hide_under: 991,
				hide_onleave: true,
				hide_delay: 200,
				hide_delay_mobile: 1200,
				left: {
					h_align: 'left',
					v_align: 'center',
					h_offset: 10,
					v_offset: 0
				},
				right: {
					h_align: 'right',
					v_align: 'center',
					h_offset: 10,
					v_offset: 0
				}
			}
		}
	}

	// Slider Init
	$('#revolutionSlider').revolution(sliderOptions);

	/*
	Dialog with CSS animation
	*/
	$('.popup-with-zoom-anim').magnificPopup({
		type: 'inline',

		fixedContentPos: false,
		fixedBgPos: true,

		overflowY: 'auto',

		closeBtnInside: true,
		preloader: false,

		midClick: true,
		removalDelay: 300,
		mainClass: 'my-mfp-zoom-in'
	});

	/*
	Contact Form Message - Home Page
	*/
	$('#callSendMessage').validate({
		submitHandler: function(form) {

			var $form = $(form),
				$messageSuccess = $('#contactFormSuccess'),
				$messageError = $('#contactFormError'),
				$submitButton = $(this.submitButton),
				$errorMessage = $('#contactFormErrorMessage');

			$submitButton.button('loading');

			// Ajax Submit
			$.ajax({
				type: 'POST',
				url: $form.attr('action'),
				data: {
					name: $form.find('#name').val(),
					email: 'you@domain.com',
					subject: 'Finance - Contact Message',
					message: 'Name' + $form.find('#name').val() + '<br>E-mail:' + $form.find('#email').val() + '<br>Phone:' + $form.find('#phone').val() + '<br>Discuss:' + $form.find('#discuss').val()
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
	Contact Form Message - Contact Us Page
	*/
	$('#contactForm').validate({
		submitHandler: function(form) {

			var $form = $(form),
				$messageSuccess = $('#contactFormSuccess'),
				$messageError = $('#contactFormError'),
				$submitButton = $(this.submitButton),
				$errorMessage = $('#contactFormErrorMessage');

			$submitButton.button('loading');

			// Ajax Submit
			$.ajax({
				type: 'POST',
				url: $form.attr('action'),
				data: {
					name: $form.find('#name').val(),
					email: 'you@domain.com',
					subject: 'Finance - Contact Message',
					message: 'Name' + $form.find('#name').val() + '<br>E-mail:' + $form.find('#email').val() + '<br>Phone:' + $form.find('#phone').val() + '<br>Select:' + $form.find('#selectSample').val() +'<br>Message:' + $form.find('#message').val()
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

}).apply(this, [jQuery]);