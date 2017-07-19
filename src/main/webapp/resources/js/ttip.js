/**
 * ToolTip: 工具栏弹出提示
 */
{
	tooltip = new Object();
	tooltip.register = function registerTTip(targetId, ttipId, tipmsg) {
		var $ttip = $('#' + targetId);
		var $ttipc = $('#' + ttipId);
		$ttip.css({
			"cursor" : "pointer"
		});
		$ttipc.css({
			"position" : "absolute",
			"display" : "none",
			"padding" : "1px 10px",
			"font-size" : "10pt",
			'background' : 'rgba(50,50,70,0.3)',
			"cursor" : "pointer"
		});
		$ttipc.text(tipmsg);
		$ttip.mouseover(function(e) {
			var xx = e.originalEvent.x || e.originalEvent.layerX || 0;
			var yy = e.originalEvent.y || e.originalEvent.layerY || 0;
			$ttipc.css({
				"left" : xx + "px",
				"top" : yy + "px",
				"display" : "block"
			});
		});
		$ttip.mouseleave(function() {
			setTimeout('tooltip.hide("' + ttipId + '")', 1500);
		});
		$ttipc.click(function() {
			tooltip.select(ttipId);
			document.execCommand("Copy");
			window.getSelection().removeAllRanges();
			alert("已复制到粘贴板");
		});
	};
	tooltip.select = function selectText(element) {
		var text = document.getElementById(element);
		if (document.body.createTextRange) {
			var range = document.body.createTextRange();
			range.moveToElementText(text);
			range.select();
		} else if (window.getSelection) {
			var selection = window.getSelection();
			var range = document.createRange();
			range.selectNodeContents(text);
			selection.removeAllRanges();
			selection.addRange(range);
		} else {
		}
	};
	tooltip.hide = function hideTTip(ttipId) {
		var $ttipc = $('#' + ttipId);
		$ttipc.hide();
	};
}