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

	$('.article-item').on('click', function () {
		var blogUrl = $(this).attr('href');
		$('#blog-iframe').attr('src', blogUrl);
		$('#blog-modal').modal({
			fadeDuration: 500,
			fadeDelay: 0.8,
		});
		return false;
	});

	$('#blog-modal').on($.modal.CLOSE, function () {
		$('#blog-iframe').attr('src', '');
	});

	const path = location.pathname;
	const isIndexOrDownload = path.endsWith('/cn/') || path.endsWith('/en/') || path.endsWith('/download.html');

	const XRAY_MODAL_LOCAL = 'xray_modal';
	let xrayModalLocal = localStorage.getItem(XRAY_MODAL_LOCAL);

	if (isIndexOrDownload && Number(xrayModalLocal) !== 1 && Number(xrayModalLocal) !== -3) {
		$('.xray-modal').removeClass('hide');
	}

	$('.xray-modal .btn-close').on('click', () => {
		xrayModalLocal = xrayModalLocal === null ? -1 : Number(xrayModalLocal) - 1;
		localStorage.setItem(XRAY_MODAL_LOCAL, xrayModalLocal);
		$('.xray-modal').addClass('hide');
  });

	$('.form-xray-request-demo').on('submit', function(event) {
		event.preventDefault();
		localStorage.setItem(XRAY_MODAL_LOCAL, 1);
		const urlPrefix = location.pathname.startsWith('/en/') ? 'https://openresty.com/en' : 'https://openresty.com.cn/cn';
		window.location.href = `${urlPrefix}/xray/request-demo/?${$(this).serialize()}`;
  });

	$('.form-xray-request-demo input').on('keydown', (event) => {
		if (event.keyCode == 13) {
			event.preventDefault();
			$('.form-xray-request-demo').submit();
		}
  });
});

document.querySelectorAll('pre code:not([class])').forEach(function ($) {
	$.className = 'no-highlight hljs';
});
hljs.initHighlightingOnLoad();
