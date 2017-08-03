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
	$table.find('tr[role="row"]').css("cursor","pointer");
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

// DataTable常量
var CONSTANT_DT = {  
	    // datatables常量  
	    DATA_TABLES : {  
	        DEFAULT_OPTION : { // DataTables初始化选项  
	            LANGUAGE : {  
	                sProcessing : "处理中...",  
	                sLengthMenu : "显示 _MENU_ 项结果",  
	                sZeroRecords : "没有匹配结果",  
	                sInfo : "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",  
	                sInfoEmpty : "显示第 0 至 0 项结果，共 0 项",  
	                sInfoFiltered : "(由 _MAX_ 项结果过滤)",  
	                sInfoPostFix : "",  
	                sSearch : "搜索:",  
	                sUrl : "",  
	                sEmptyTable : "表中数据为空",  
	                sLoadingRecords : "载入中...",  
	                sInfoThousands : ",",  
	                oPaginate : {  
	                    sFirst : "首页",  
	                    sPrevious : "上页",  
	                    sNext : "下页",  
	                    sLast : "末页"  
	                },  
	                "oAria" : {  
	                    "sSortAscending" : ": 以升序排列此列",  
	                    "sSortDescending" : ": 以降序排列此列"  
	                }  
	            },  
	            // 禁用自动调整列宽  
	            autoWidth : false,  
	            // 为奇偶行加上样式，兼容不支持CSS伪类的场合  
	            stripeClasses : [ "odd", "even" ],  
	            // 取消默认排序查询,否则复选框一列会出现小箭头  
	            order : [],  
	            // 隐藏加载提示,自行处理  
	            processing : false,  
	            // 启用服务器端分页  
	            serverSide : true,  
	            // 禁用原生搜索  
	            searching : false  
	        },  
	        COLUMN : {  
	            // 复选框单元格  
	            CHECKBOX : {  
	                className: "td-checkbox",  
	                orderable : false,  
	                bSortable : false,  
	                data : "id",  
	                width:"20px",
	                title: "<th>  "+
	                       '<label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">'+  
	                       '<input type="checkbox" name="keeperUserGroup-checkable" class="group-checkable" data-set="#sample_1 .checkboxes" />'+  
	                       "<span></span>"+  
	                       "</label>"+  
	                       "</th>  ",
	                render : function(data, type, row, meta) {  
	                    var content = '<label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">';  
	                    content += '    <input type="checkbox" class="group-checkable" value="' + data + '" />';  
	                    content += '    <span></span>';  
	                    content += '</label>';  
	                    return content;  
	                }  
	            }  
	        },  
	        // 常用render可以抽取出来，如日期时间、头像等  
	        RENDER : {  
	            ELLIPSIS : function(data, type, row, meta) {  
	                data = data || "";  
	                return '<span title="' + data + '">' + data + '</span>';  
	            }  
	        }  
	    }  
	};  

function select(element) {
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
}

/**
 * 拷贝链接
 * 
 * @param remoteUrl
 * @returns
 */
function copyData(data) {
    if(!$("#copySpan_")[0]){
        $("body").append("<span id='copySpan_'></span>");
    }
    $("#copySpan_").text(data);
    if (!select("copySpan_")) {
        return;
    }
    document.execCommand("Copy");
    window.getSelection().removeAllRanges();
}