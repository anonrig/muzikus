/*
Name: 			Shop15
Written by: 	Okler Themes - (http://www.okler.net)
Theme Version:	5.7.2
*/

(function( $ ) {

	// Newsletter popup
	if ( document.getElementById('newsletter-popup-form') ) {
		$.magnificPopup.open({
			items: {
				src: '#newsletter-popup-form'
			},
			type: 'inline'
		}, 0);
	}

	// New Products Carousel
	$('.new-products-carousel').owlCarousel({
		loop: false,
		responsive: {
			0: {
				items: 1
			},
			480: {
				items: 2
			},
			768: {
				items: 3
			},
			992: {
				items: 4
			},
			1200: {
				items: 5
			}
		},
		margin: 20,
		nav:false,
		navText: [],
		dots: true,
		autoWidth: false
	});

	// New Products Carousel
	$('.new-products2-carousel').owlCarousel({
		loop: false,
		responsive: {
			0: {
				items: 1
			},
			480: {
				items: 2
			},
			768: {
				items: 3
			},
			992: {
				items: 4
			},
			1200: {
				items: 5
			}
		},
		margin: 20,
		nav:false,
		navText: [],
		dots: true,
		autoWidth: false
	});

	// Mobile menu accordion
	$('.mobile-side-menu').find('.mmenu-toggle').on('click', function (e) {
		var closestLi = $(this).closest('li');

		if (closestLi.find('ul').length) {
			closestLi.children('ul').slideToggle(300, function () {
				closestLi.toggleClass('open');
			});
			e.preventDefault();
		}
	});

	// Mobile menu show/hide 
	$('.mmenu-toggle-btn, #mobile-menu-overlay').on('click', function (e) {
		$('.body').toggleClass('mmenu-open');
		e.preventDefault();
	});	

	// Search Dropdown Toggle
	$('.search-toggle').on('click', function (e) {
		$('.header-search-wrapper').toggleClass('open');
		e.preventDefault();
	});

	// Toggle new/change password section via checkbox
	$('#change-pass-checkbox').on('change', function () {
		$('#account-chage-pass').toggleClass('show');
	});

	// Toggle creditcard section -- see checkout page
	$('.payment-card-check').on('change', function () {
		var cardArea = $('#payment-credit-card-area');
		switch($(this).val()) {
	        case 'checkcard':
	            cardArea.addClass('show');
	            break;
            case 'checkmo':
	            cardArea.removeClass('show');
	            break;
	    }       
	});

	// Vertical Spinner - Touchspin - Product Details Quantity input
	if ( $.fn.TouchSpin ) {
		$('#product-vqty').TouchSpin({
			verticalbuttons: true
	    });
	}

	// Filter Price Slider
	if (typeof noUiSlider === 'object') {
		var priceSlider = document.getElementById('price-slider'),
			priceLow 	= document.getElementById('price-range-low'),
			priceHigh 	= document.getElementById('price-range-high');

		// Create Slider
		noUiSlider.create(priceSlider, {
			start: [ 50, 250 ],
			connect: true,
			step: 1,
			range: {
				'min': 0,
				'max': 300
			}
		});

		// Update Input values
		priceSlider.noUiSlider.on('update', function( values, handle ) {
			var value = values[handle];

			if ( handle ) {
				priceHigh.value = Math.round(value);
			} else {
				priceLow.value = Math.round(value);
			}
		});

		// when inpout values changei update slider
		priceLow.addEventListener('change', function(){
			priceSlider.noUiSlider.set([this.value, null]);
		});

		priceHigh.addEventListener('change', function(){
			priceSlider.noUiSlider.set([null, this.value]);
		});
	}

	// Product Details Gallery 
	if ($.fn.elevateZoom) {
		$('#product-zoom').elevateZoom({
			responsive: true,
			zoomType: "inner",
			cursor: "default"
		});
	}

	$('#productGalleryThumbs')
		.owlCarousel({
			margin: 10,
			items: 4,
			nav: false,
			center: false,
			dots: false,
			autoplay: false
		})
		.on('click', '.owl-item', function(e) {
			var ez = $('#product-zoom').data('elevateZoom'),
				targetLink= $(this).find('a'),
				smallImg = targetLink.data('image'),
				bigImg = targetLink.data('zoom-image');

			// Sync data-zoom-image for gallery
			$('#product-zoom').attr('data-zoom-image',bigImg);

			// prevent default
			$.magnificPopup.close();

			ez.swaptheimage(smallImg, bigImg);
		});

	// Set up gallery on click
	var galleryZoom = $('#productGalleryThumbs');
	galleryZoom.magnificPopup({
		delegate: 'a',
		type: 'image',
		gallery:{
		    enabled: true
		},
		callbacks: {
		    elementParse: function(item) {
			    item.src = item.el.attr('data-zoom-image');
			}
		}
	});

	// Zoom image when click on icon
	$('.product-img-zoom').on('click', function(){
		var current = $('#product-zoom').attr('data-zoom-image');

		$('#productGalleryThumbs .owl-item').each(function(){
			if( current == $(this).find('.product-gallery-item').attr('data-zoom-image') ) {
				return galleryZoom.magnificPopup('open', $(this).index());
			}
		});
	});

	// No def events for links
	$('#productGalleryThumbs').find('a').on('click', function (e) {
		e.preventDefault();
	});

	// Newsletter Checkbox Cookie - Check if has newsCheck cookie
	if( getCookie('newsCheck') != '' ) {
		$.magnificPopup.close();
	}

	// Create cookie or delete depending the checkbox
	$('.newsletter-subscribe input[type="checkbox"]').on('change', function(){
		if( $(this).prop('checked') ) {
			setCookie('newsCheck', 'true', 30); // Expires in 30 days
		} else {
			setCookie('newsCheck', 'true', 0);
		}
	});

	// Set cookie
	function setCookie(cname, cvalue, exdays) {
	    var d = new Date();
	    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
	    var expires = "expires="+d.toUTCString();
	    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
	}

	// Get cookie
	function getCookie(cname) {
	    var name = cname + "=";
	    var ca = document.cookie.split(';');
	    for(var i = 0; i < ca.length; i++) {
	        var c = ca[i];
	        while (c.charAt(0) == ' ') {
	            c = c.substring(1);
	        }
	        if (c.indexOf(name) == 0) {
	            return c.substring(name.length, c.length);
	        }
	    }
	    return "";
	}
    
}).apply( this, [ jQuery ]);