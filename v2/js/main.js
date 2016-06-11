var UI = {

	init: function() {
		this.navigation();

		this.fixHeaderHeight();
	},

	navigation: function() {
		var trigger = $('#bar .trigger');

		trigger.on('click', function(event) {
			event.preventDefault();
			$('#bar .left').show();
			$('#bar .right').addClass('open');
			$(this).hide();
		});
	},

    fixHeaderHeight: function() {
        function update(ev) {
            $(document.body).css(
                'paddingTop',
                Math.max($('header[role="header"]').outerHeight(), 88)
            );
        }

        $(window).on('resize', update);
        setTimeout(update, 0);
    }
}

$(document).ready(function() {

	UI.init();

});
