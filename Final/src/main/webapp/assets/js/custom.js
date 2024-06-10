$(window).on('load', function() {
	// 커버 요소가 있을 경우 parallax 효과를 설정하는 코드
	if ($('.cover').length) {
		$('.cover').parallax({
			imageSrc: $('.cover').data('image'),
			zIndex: '1'
		});
	}

	// 3초 동안 대기한 후 pre-loader를 숨기는 코드
	setTimeout(function() {
		$('#js-preloader').addClass('loaded');
	}, 600); 

	// #preloader 요소를 숨기는 애니메이션 코드 (불필요한 경우 생략 가능)
	$("#preloader").animate({
		'opacity': '0'
	}, 400, function() {
		setTimeout(function() {
			$("#preloader").css("visibility", "hidden").fadeOut();
		}, 300);
	});
});




(function($) {

	"use strict";

	// WOW JS
	$(window).on('load', function() {
		if ($(".wow").length) {
			var wow = new WOW({
				boxClass: 'wow',      // Animated element css class (default is wow)
				animateClass: 'animated', // Animation css class (default is animated)
				offset: 20,         // Distance to the element when triggering the animation (default is 0)
				mobile: true,       // Trigger animations on mobile devices (default is true)
				live: true,       // Act on asynchronously loaded content (default is true)
			});
			wow.init();
		}
	});


	$('.filters ul li').click(function() {
		$('.filters ul li').removeClass('active');
		$(this).addClass('active');

		var data = $(this).attr('data-filter');
		$grid.isotope({
			filter: data
		});
	});


	var $grid = $(".grid").isotope({
		itemSelector: ".all",
		percentPosition: true,
		masonry: {
			columnWidth: ".all"
		}
	})

	var width = $(window).width();
	$(window).resize(function() {
		if (width > 992 && $(window).width() < 992) {
			location.reload();
		}
		else if (width < 992 && $(window).width() > 992) {
			location.reload();
		}
	})



	$(document).on("click", ".naccs .menu div", function() {
		var numberIndex = $(this).index();

		if (!$(this).is("active")) {
			$(".naccs .menu div").removeClass("active");
			$(".naccs ul li").removeClass("active");

			$(this).addClass("active");
			$(".naccs ul").find("li:eq(" + numberIndex + ")").addClass("active");

			var listItemHeight = $(".naccs ul")
				.find("li:eq(" + numberIndex + ")")
				.innerHeight();
			$(".naccs ul").height(listItemHeight + "px");
		}
	});

	$('.owl-features').owlCarousel({
		items: 3,
		loop: true,
		dots: false,
		nav: true,
		autoplay: false,
		margin: 30,
		responsive: {
			0: {
				items: 1
			},
			600: {
				items: 2
			},
			1200: {
				items: 4
			},
			1800: {
				items: 4
			}
		}
	})

	$('.owl-collection').owlCarousel({
		items: 3,
		loop: true,
		dots: false,
		nav: true,
		autoplay: false,
		margin: 30,
		responsive: {
			0: {
				items: 1
			},
			800: {
				items: 3
			},
			1000: {
				items: 4
			}
		}
	})


	$(document).ready(function() {
		$(document).on("scroll", onScroll);

		//smoothscroll
		$('.scroll-to-section a[href^="#"]').on('click', function(e) {
			e.preventDefault();
			$(document).off("scroll");

			$('.scroll-to-section a').each(function() {
				$(this).removeClass('active');
			})
			$(this).addClass('active');

			var target = this.hash,
				menu = target;
			var target = $(this.hash);
			$('html, body').stop().animate({
				scrollTop: (target.offset().top) - 79
			}, 500, 'swing', function() {
				window.location.hash = target;
				$(document).on("scroll", onScroll);
			});
		});
	});

	// refElement가 존재하는가?
	function onScroll(event) {
		var scrollPos = $(document).scrollTop();
		$('.nav a').each(function() {
			var currLink = $(this);
			var refElement = $(currLink.attr("href"));

			// refElement가 존재하는지 확인
			if (refElement.length) {
				if (refElement.position().top <= scrollPos && refElement.position().top + refElement.height() > scrollPos) {
					$('.nav ul li a').removeClass("active");
					currLink.addClass("active");
				} else {
					currLink.removeClass("active");
				}
			}
		});
	}

	const dropdownOpener = $('.main-nav ul.nav .has-sub > a');

	// Open/Close Submenus
	if (dropdownOpener.length) {
		dropdownOpener.each(function() {
			var _this = $(this);

			_this.on('tap click', function(e) {
				var thisItemParent = _this.parent('li'),
					thisItemParentSiblingsWithDrop = thisItemParent.siblings('.has-sub');

				if (thisItemParent.hasClass('has-sub')) {
					var submenu = thisItemParent.find('> ul.sub-menu');

					if (submenu.is(':visible')) {
						submenu.slideUp(450, 'easeInOutQuad');
						thisItemParent.removeClass('is-open-sub');
					} else {
						thisItemParent.addClass('is-open-sub');

						if (thisItemParentSiblingsWithDrop.length === 0) {
							thisItemParent.find('.sub-menu').slideUp(400, 'easeInOutQuad', function() {
								submenu.slideDown(250, 'easeInOutQuad');
							});
						} else {
							thisItemParent.siblings().removeClass('is-open-sub').find('.sub-menu').slideUp(250, 'easeInOutQuad', function() {
								submenu.slideDown(250, 'easeInOutQuad');
							});
						}
					}
				}
				e.preventDefault();
			});
		});
	}
})(window.jQuery);


