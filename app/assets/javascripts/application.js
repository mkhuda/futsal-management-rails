// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require tether
//= require bootstrap-sprockets
//= require bxslider
//= require underscore
//= require moment
//= require gmaps/google
//= require bootstrap-datetimepicker
//= require bootstrap-datepicker
//= require bootstrap-datepicker/core
//= require turbolinks
//= require nprogress
//= require nprogress-turbolinks
//= require_tree .


var ready;
ready = function() {

$(function(){

	$(document).on( 'scroll', function(){

		if ($(window).scrollTop() > 100) {
			$('.scroll-top-wrapper').addClass('show');
		} else {
			$('.scroll-top-wrapper').removeClass('show');
		}
	});

	$('.scroll-top-wrapper').on('click', scrollToTop);
});

function scrollToTop() {
	verticalOffset = typeof(verticalOffset) != 'undefined' ? verticalOffset : 0;
	element = $('body');
	offset = element.offset();
	offsetTop = offset.top;
	$('html, body').animate({scrollTop: offsetTop}, 500, 'linear');
}

$(".list-box").hover(function() {
      // $(this).children(".actions-box").css("display", "block");
      $(this).children(".actions-box").slideDown("fast");
    }, function() {
      
      $(this).children(".actions-box").slideUp("fast");
      $(this).children(".actions-box").css("display", "none");
    });

    var target = window.location.href.split('#');
    $('.nav a').filter('[href="#'+target[1]+'"]').tab('show');

	$(document).delegate('*[data-toggle="lightbox"]', 'click', function(event) {
	    event.preventDefault();
	    $(this).ekkoLightbox();
	}); 

	$('.lightbox-gallery').click(function(e){
		e.preventDefault();
		$(this).ekkoLightbox({
			gallery: "gallery"
		});	
	});
	
	$("img.load").lazyload();

	$(".btn-testimoni").click(function(e){
		$("#form-testimoni").slideDown("fast");
	});

	 $('.bxslider').bxSlider({
		minSlides: 4,
		maxSlides: 5,
		slideWidth: 360,
		slideMargin: 10
	 });
};

$(document).ready(ready);
$(document).on('page:load', ready);