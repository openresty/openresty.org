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

	var blogModal = document.getElementById('blog-modal');
	var blogIframe = document.getElementById('blog-iframe');

	// Only allow the OpenResty blog origins to be embedded in the modal
	// iframe; a compromised or hijacked RSS feed must not be able to load
	// an arbitrary third-party page here (clickjacking / phishing).
	var allowedIframeHosts = ['blog.openresty.com', 'blog.openresty.com.cn'];

	function isAllowedIframeUrl(url) {
		try {
			var host = new URL(url, window.location.origin).hostname;
			return allowedIframeHosts.indexOf(host) !== -1;
		} catch (e) {
			return false;
		}
	}

	if (blogModal && blogIframe) {
		$('.article-item').on('click', function (event) {
			event.preventDefault();
			var href = $(this).attr('href');
			if (isAllowedIframeUrl(href)) {
				blogIframe.src = href;
				blogModal.showModal();
			}
		});

		$('.blog-modal-close').on('click', function () {
			blogModal.close();
		});

		blogModal.addEventListener('click', function (event) {
			if (event.target === blogModal) {
				blogModal.close();
			}
		});

		blogModal.addEventListener('close', function () {
			blogIframe.src = '';
		});
	}
});

document.querySelectorAll('pre code:not([class])').forEach(function ($) {
	$.className = 'no-highlight hljs';
});
hljs.highlightAll();
