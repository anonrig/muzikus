/*
Name: 			Core Initializer
Written by: 	Crivos - (http://www.crivos.com)
Version: 		1.0
*/

var Core = {

	initialized: false,

	initialize: function() {

		if (this.initialized) return;
		this.initialized = true;

		this.build();
		this.events();

	},

	build: function() {

		// Adds browser version on html class.
		$.browserSelector();
		
		// Scroll to Top Button.
		$.scrollToTop();

		// Responsive Navigation.
		selectnav("mainMenu");

		// Featured Boxes
		this.featuredBoxes();

		// Flexslider
		this.flexSlider();

		// Tooltips
		$("a[rel=tooltip]").tooltip();

		// Sort
		this.sort();

		// Toggle
		this.toggle();

		// Twitter
		this.latestTweets();

		// Flickr Feed
		this.flickrFeed();

		// Fancybox
		this.fancybox();

	},

	events: function() {

		// Top Nav
		$("#mainMenu li.dropdown").hover(function() {
			$(this).addClass("open");
		}, function() {
			$(this).removeClass("open");
		});

		// Window Resize
		$(window).on("resize", function() {
			var timer = window.setTimeout(function() {
				window.clearTimeout(timer);

				// Flexslider
				Core.flexSlider();

				// Featured Boxes
				Core.featuredBoxes();

			}, 50);
		});

	},

	featuredBoxes: function() {

		$("div.featured-box").css("height", "auto");

		$("div.featured-boxes").each(function() {

			var wrapper = $(this);
			var minBoxHeight = 0;

			$("div.featured-box", wrapper).each(function() {
				if($(this).height() > minBoxHeight)
					minBoxHeight = $(this).height();
			});

			$("div.featured-box", wrapper).height(minBoxHeight);

		});

	},

	flexSlider: function(options) {

		$("div.flexslider").each(function() {

			var slider = $(this);

			var defaults = {
				animationLoop: false,
				controlNav: true,
				directionNav: true
			}
			
			var config = $.extend({}, defaults, options, slider.data("plugin-options"));
			
			if(($(window).width() < 768 && slider.hasClass("normal-device")) || $(window).width() > 768 && slider.hasClass("small-device") || (!slider.hasClass("flexslider-init"))) {

				// Reset if already initialized.
				if(slider.find("div.flex-viewport") && typeof(config.maxVisibleItems) != "undefined") {

					var el = slider;
					var elClean = el.clone();

					elClean.find("div.flex-viewport").children().unwrap();

					elClean
						.find("ul.flex-direction-nav, ol.flex-control-nav")
						.remove()
						.end()
						.find("*").removeAttr("style").removeClass (function (index, css) {
							return (css.match (/\bflex\S+/g) || []).join(" ");
						});

					elClean.insertBefore(el);

					el.remove();

					slider = elClean;

				}

				// Set max visible items.
				if(typeof(config.maxVisibleItems) != "undefined") {

					slider.find("ul.slides li > div").unwrap();

					var items = slider.find("ul.slides").children("div");
					var visibleItems = config.maxVisibleItems;

					if($(window).width() < 768) {
						visibleItems = 1;
						slider
							.removeClass("normal-device")
							.addClass("small-device");
					} else {
						slider
							.removeClass("small-device")
							.addClass("normal-device");
					}

					for (var i = 0; i < items.length; i+= visibleItems) {
						var slice = items.slice(i,i + visibleItems);

						slice.wrapAll("<li></li>");
					}

				}

			}

			// Initialize Slider
			slider.flexslider(config).addClass("flexslider-init");

			if(config.controlNav)
				slider.addClass("flexslider-control-nav");

			if(config.directionNav)
				slider.addClass("flexslider-direction-nav");

		});

	},

	sort: function() {

		$("ul.sort-source").each(function() {

			var source = $(this);
			var destination = $("ul.sort-destination[data-sort-id=" + $(this).attr("data-sort-id") + "]");

			if(destination.get(0)) {

				var minParagraphHeight = 0;
				var paragraphs = $("span.thumb-info-caption p", destination);

				paragraphs.each(function() {
					if($(this).height() > minParagraphHeight)
						minParagraphHeight = $(this).height();
				});

				paragraphs.height(minParagraphHeight);

				$(window).load(function() {

					destination.isotope({
						itemSelector: "li",
						layoutMode : "fitRows"
					});

					source.find("a").click(function(e) {

						e.preventDefault();

						var $this = $(this);

						source.find("li.active").removeClass("active");
						$(this).parent().addClass("active");

						destination.isotope({
							filter: $this.parent().attr("data-option-value")
						});

						return false;

					});

				});

			}

		});

	},

	toggle: function() {

		$("section.toggle label").prepend($("<i />").addClass("icon-plus"));
		$("section.toggle label").prepend($("<i />").addClass("icon-minus"));

		if ($("html").hasClass("ie8")) {

			$("section.toggle input").click(function() {
				$(this).parent().toggleClass("active");
			});

		}

	},

	fancybox: function() {

		$(".fancybox").fancybox();

	},

	flickrFeed: function(options) {

		$("ul.flickr-feed").each(function() {

			var el = $(this);

			var defaults = {
				limit: 6,
				qstrings: {
					id: ''
				},
				itemTemplate: '<li><a rel="flickr" href="{{image_b}}" class="fancybox"><span class="thumbnail"><img alt="{{title}}" src="{{image_s}}" /></span></a></li>'
			}

			var config = $.extend({}, defaults, options, el.data("plugin-options"));

			el.jflickrfeed(config, function(data) {

				$(".fancybox[rel=flickr]").fancybox();

			});

		});

	},

	latestTweets: function() {

		getTwitters("tweet", { 
			id: "envato", 
			count: 1, 
			enableLinks: true, 
			ignoreReplies: true, 
			clearContents: true,
			template: '<i class="icon-twitter"></i> "%text%" <a class="time" href="http://twitter.com/%user_screen_name%/statuses/%id_str%/">%time%</a>'
		});

	}

};

Core.initialize();