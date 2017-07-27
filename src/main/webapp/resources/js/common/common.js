/**
 * 隔行变色
 * 
 * @author yinzf
 * @createtime 2014.11.10
 * @param $table
 */
function tableStriped($table) {
	$table.find('tr:even').addClass('even').end().find('tr:odd')
			.addClass('odd');
}

/**
 * 将表单数据直接转成json
 */
$.fn.serializeObject = function() {
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		if (o[this.name] !== undefined) {
			if (!o[this.name].push) {
				o[this.name] = [ o[this.name] ];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		}
	});
	return o;
};

// 用来存放当前正在操作的日期文本框的引用。
var datepicker_CurrentInput;
$.fn.addClearButtonForDatepicker = function() {
	// 设置DatePicker 的默认设置
	$.datepicker.setDefaults({
		showButtonPanel : true,
		closeText : 'Clear',
		beforeShow : function(input, inst) {
			datepicker_CurrentInput = input;
		}
	});

	// 绑定“Done”按钮的click事件，触发的时候，清空文本框的值
	$(".ui-datepicker-close").live("click", function() {
		datepicker_CurrentInput.value = "";
	});
}