/**
 * ToolTip: 工具栏弹出提示
 */
var ToolTip = function(targetId, ttipId, tipmsg) {
	var _this = this; // this的全局引用，可在回调函数使用

	this.targetId = targetId;
	this.ttipId = ttipId;
	this.tipmsg = tipmsg;
	this.$ttip = $('#' + targetId);
	this.$ttipc = $('#' + ttipId);

	this.$bgcolor_ = 'rgba(0,0,0,0.7)';
	this.$color_ = '#fff';
	this.$timeout_ = 1000; // tip信息消失延迟
	this.$isHtml_ = false;
	this.$fontSize_ = "10pt";
	this.$delay_ = 1000; // 悬停显示延迟

	this.register = function() {
		this.$ttip.css({
			"cursor" : "pointer"
		});
		this.$ttipc.css({
			"position" : "absolute",
			"display" : "none",
			"padding" : "5px 10px",
			"font-size" : this.$fontSize_,
			'background' : this.$bgcolor_,
			'color' : this.$color_,
			"cursor" : "pointer"
		});
		
		// 延迟出现hover事件
		this.$ttip.on({
	        "mouseenter": function() {
	        	clearTimeout(ToolTip.timerLeave);
	            clearTimeout(ToolTip.timerEnter);
	            ToolTip.timerEnter = setTimeout(function() {
	    			if (!_this.$isHtml_) {
	    				_this.$ttipc.text(tipmsg);
	    			} else {
	    				_this.$ttipc.html(tipmsg);
	    			}
	    			_this.$ttipc.css({
	    				"left" : (ToolTip.mousePosX+20) + "px",
	    				"top" : (ToolTip.mousePosY-5) + "px",
	    			});
	    			_this.$ttipc.hide();
	    			_this.$ttipc.fadeIn('slow');
	            }, 1000); // 悬停一秒
	        },
	        "mouseleave": function() {
	        	clearTimeout(ToolTip.timerLeave);
	            clearTimeout(ToolTip.timerEnter);
	            ToolTip.timerLeave = setTimeout(function() {
					_this.$ttipc.fadeOut('slow');
				}, _this.$timeout_);
	        },
	        "mousemove": function(e) {
	        	ToolTip.mousePosX = e.originalEvent.x || e.originalEvent.layerX || 0;
	        	ToolTip.mousePosY = e.originalEvent.y || e.originalEvent.layerY || 0;
	        }
	    });
		this.$ttipc.off('click'); // 防止重复绑定
		this.$ttipc.on('click',function() {
			if (!select(ttipId)) {
				return;
			}
			document.execCommand("Copy");
			window.getSelection().removeAllRanges();
			alert("已复制到粘贴板");
		});
	};

	/**
	 * 设置背景颜色
	 * @param bgcolor 背景颜色
	 * @param alpha 透明度
	 */
	this.bgColor = function(bgcolor, alpha) {
		this.$bgcolor_ = parseRgbafunStr(bgcolor, alpha);
		return this;
	};

	/**
	 * 设置前景色
	 * @param color 16进制颜色，支持3位6位两种表示方法(#f00,#ff00aa)
	 */
	this.color = function(color) {
		this.$color_ = color;
		return this;
	};

	/**
	 * 鼠标移除后，提示窗口停留时间
	 * @param timeout 单位毫秒
	 */
	this.timeout = function(timeout) {
		this.$timeout_ = timeout;
		return this;
	};

	/**
	 * 内容html格式
	 */
	this.html = function() {
		this.$isHtml_ = true;
		return this;
	};

	/**
	 * 内容为text格式
	 */
	this.text = function() {
		this.$isHtml_ = false;
		return this;
	};
	
	/**
	 * 指定文字字体大小
	 */
	this.fontSize = function(fontSize) {
		this.$fontSize_ = fontSize;
		return this;
	};

	/**
	 * 悬停延迟：鼠标进入监控元素多久之后，显示Tip
	 */
	this.delay = function(delay) {
		this.$delay_ = delay;
		return this;
	};

	/**
	 * 将16进制表示的颜色字符串转换成，rgba函数调用字符串
	 */
	var parseRgbafunStr = function(bgcolor, alpha) {
		if (!bgcolor && bgcolor.length == 0 && bgcolor.length < 3) {
			return _this.$bgcolor_;
		}

		var colStr = bgcolor;
		if (bgcolor.indexOf('#') == 0) {
			colStr = bgcolor.substring(1, bgcolor.length);
		}

		if (colStr.length != 3 && colStr.length != 6) {
			return _this.$bgcolor_;
		}

		var num = new Array(3);
		if (bgcolor) {
			if (colStr.length = 3) {
				num[0] = colStr.substring(0, 1) + colStr.substring(0, 1);
				num[1] = colStr.substring(1, 2) + colStr.substring(1, 2);
				num[2] = colStr.substring(2, 3) + colStr.substring(2, 3);
			} else {
				num[0] = colStr.substring(0, 2);
				num[1] = colStr.substring(2, 4);
				num[2] = colStr.substring(4, 6);
			}
		}

		var rs = '';
		for ( var i in num) {
			rs += parseInt(num[i], 16) + ",";
		}
		return "rgba(" + rs + alpha + ")";
	};

	// 选中某个HTML元素的文本内容
	var select = function(element) {
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
			return false;
		}
		return true;
	};
};
ToolTip.timerEnter = null; // 鼠标进入定时器
ToolTip.timerLeave = null; // 鼠标离开定时器