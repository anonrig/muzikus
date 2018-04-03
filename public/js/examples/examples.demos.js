/*
Name: 			Demos - Examples
Written by: 	Okler Themes - (http://www.okler.net)
Theme Version:	5.7.2
*/

(function( $ ) {

	'use strict';

	// Sample Demos List
	var $sampleItemList = $('#sampleItemList'),
		$window = $(window);

	$sampleItemList.on('arrangeComplete', function() {
		$sampleItemList.addClass('sample-item-list-loaded');
		$window.trigger('scroll');
	});

	$sampleItemList.isotope({
		itemSelector: '.isotope-item',
		sortBy : 'random',
		layoutMode: 'fitRows',
		hiddenStyle: {
			opacity: 0
		},
		visibleStyle: {
			opacity: 1
		}
	});

	// Shop Demo
	var $shopDemoItem = $($('#shopDemo').html());

	$sampleItemList.prepend($shopDemoItem).isotope('prepended', $shopDemoItem);

	// Main Demo
	var $mainDemoItem = $($('#mainDemo').html());

	$sampleItemList.prepend($mainDemoItem).isotope('prepended', $mainDemoItem);

	// Coming Soon
	var $comingSoonItem = $($('#comingSoon').html());

	$sampleItemList.append($comingSoonItem).isotope('appended', $comingSoonItem);

	setTimeout(function() {
		$sampleItemList.trigger('arrangeComplete');
	}, 1000);

	$sampleItemList.find('.owl-carousel').on('changed.owl.carousel', function(event) {
		setTimeout(function() {
			$window.trigger('scroll');
		}, 300);
	});

	// Carousels
	$('.owl-carousel-demos').each(function() {
		$(this).owlCarousel({
			items: 1,
			margin: 0,
			loop: true,
			nav: true,
			dots: false,
			stagePadding: 0,
			navText: [],
			autoplay: false,
			autoplayTimeout: Math.floor(Math.random() * (12000 - 6000 + 1)) + 6000
		}).addClass('owl-carousel-init');
		
		$(this).on('changed.owl.carousel', function(event) {
			$(this).find('.owl-item:eq(' + event.item.index + ')').trigger('scroll');
		});
	});

	//	Open Demo Options
	$('.open-demo-options').magnificPopup({
		type: 'inline',

		fixedContentPos: true,
		closeBtnInside: false,
		closeOnContentClick: true,
		preloader: false,

		midClick: true,
		removalDelay: 300,
		mainClass: 'mfp-demo-options mfp-fade',
		callbacks: {
			open: function() {
				$('html').addClass('lightbox-opened');

				setTimeout(function() {
					$(window).trigger('scroll');
				}, 1000);
			},
			close: function() {
				$('html').removeClass('lightbox-opened');
			}
		}
	});

	// Lazy Load
	$.extend(theme.PluginLazyLoad.defaults, {
		container: $('.main')
	});

}).apply( this, [ jQuery ]);