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
	// hljs.configure({languages:});

});

document.querySelectorAll('pre code:not([class])').forEach(function ($) {
	$.className = 'no-highlight hljs';
});
hljs.initHighlightingOnLoad();
