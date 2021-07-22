var UI = {

	init: function() {
		this.navigation();
	},

	navigation: function() {
		var trigger = $('#bar .trigger');

		trigger.on('click', function(event) {
			event.preventDefault();
			$('#bar .left').show();
			$('#bar .right').addClass('open');
			$(this).hide();
		});
	}
}

$(document).ready(function() {

	UI.init();

	// for each header link, click to copy the permalink
	$('.header-anchor').on('click', function () {
		var url = location.origin + location.pathname + $(this).attr('href');

		var $temp = $('<input style="position: absolute; left: -9999px; bottom: 0;">');
		$("body").append($temp);
		$temp.val(url).select();

		try {
			document.execCommand("copy");
		} catch (e) {
			alert('Failed to copy to clipboard, please try again or use other browsers.')
		}
	})

	var blogUrl = '';
	$('.article-item').on('click', function (event) {
		blogUrl = event.target.getAttribute('href');
		$('#blog-modal').modal('show');
	});

	$('#blog-modal').on('shown.bs.modal', function () {
		$('#blog-iframe').attr('src', blogUrl);
	});

	$('#blog-modal').on('hide.bs.modal', function () {
		$('#blog-iframe').attr('src', '');
	});

});

document.querySelectorAll('pre code:not([class])').forEach(function ($) {
	$.className = 'no-highlight hljs';
});
hljs.initHighlightingOnLoad();
