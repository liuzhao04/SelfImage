var initTableUrl = JS_CTX + "/image/initTable.do";
var delImageUrl = JS_CTX + "/image/delImage.do";
var batchDelImageUrl = JS_CTX + "/image/batchDelImage.do";

var myControl=  {
		create: function(tp_inst, obj, unit, val, min, max, step){
			$('<input class="ui-timepicker-input" value="'+val+'" style="width:50%">')
				.appendTo(obj)
				.spinner({
					min: min,
					max: max,
					step: step,
					change: function(e,ui){ // key events
							// don't call if api was used and not key press
							if(e.originalEvent !== undefined)
								tp_inst._onTimeChange();
							tp_inst._onSelectHandler();
						},
					spin: function(e,ui){ // spin events
							tp_inst.control.value(tp_inst, obj, unit, ui.value);
							tp_inst._onTimeChange();
							tp_inst._onSelectHandler();
						}
				});
			return obj;
		},
		options: function(tp_inst, obj, unit, opts, val){
			if(typeof(opts) == 'string' && val !== undefined)
				return obj.find('.ui-timepicker-input').spinner(opts, val);
			return obj.find('.ui-timepicker-input').spinner(opts);
		},
		value: function(tp_inst, obj, unit, val){
			if(val !== undefined)
				return obj.find('.ui-timepicker-input').spinner('value', val);
			return obj.find('.ui-timepicker-input').spinner('value');
		}
	};

$(document).ready(function() {
	$queryGrid = $("#queryGrid");
	initQueryTable($queryGrid);
	initQueryWindow();
});



function initQueryWindow() {
	var startDateTextBox = $('#datepickerStart');
	var endDateTextBox = $('#datepickerEnd');
	//$.timepicker.setDefaults({controlType: myControl});
	$.timepicker.datetimeRange(
		startDateTextBox,
		endDateTextBox,
		{
			minInterval: (1000*60*60), // 1hr
			dateFormat: 'yy-mm-dd', 
			timeFormat: 'HH:mm:ss',
			start: {showSecond:true}, // start picker options
			end: {
				showSecond:true,
			}
		}
	);
	
	
	$("#button-search-images").button({
		icon : "ui-icon-search",
		showLabel : true
	});
	
	$("#button-search-images").click(function(){
		queryImages();
	});
	
}




function initQueryTable($table) {
	$table
			.jqGrid({
				url : initTableUrl,
				mtype : 'POST',
				loadonce : false,
				datatype : 'json',
				height : '100%',
				shrinkToFit : true,
				multiselect : true,
				rownumbers : true,
				colNames : [ 'ImageID', '上传批次', '图片名称', '文件大小', '创建时间', '操作',
						'远程路径' ],

				// cmTemplate: { title: false },
				colModel : [ {
					name : 'imageId',
					hidden : false,
					sortable : false,
					width : 80,
					align : 'center'
				}, {
					name : 'batchId',
					width : 250,
					sortable : false,
					align : 'center'
				}, {
					name : 'name',
					index : 'name',
					width : 250,
					align : 'left',
				}, {
					name : 'fileSize',
					index : 'fileSize',
					width : 100,
					sortable : true,
					align : 'center'
				}, {
					name : 'createTimeStr',
					index : 'createTime',
					width : 160,
					sortable : true,
					align : 'center'
				}, {
					name : 'action',
					width : 100,
					align : 'center'
				// title : false
				}, {
					name : 'remoteUrl',
					hidden : true
				} ],
				rowNum : 10,
				rowList : [ 10, 20, 30 ],
				pager : '#queryGridPager',
				gridview : true,
				viewrecords : true,
				postData : {},
				jsonReader : {
					root : 'data',
					page : 'pageIndex',
					total : 'pageCount',
					records : 'count',
					repeatitems : false,
					userdata : 'userData'
				},
				gridComplete : function() {
					tableStriped($table);
					var indexs = $table.jqGrid('getDataIDs');
					for (var i = 0; i < indexs.length; i++) {
						var rowId = indexs[i];
						var currentRow = $table.jqGrid('getRowData', rowId);
						var url = currentRow.remoteUrl.replace(/\\/g, '/');
						var operatorButton = '<a id="copy_query_button_'
								+ i
								+ '" class="ui-state-default ui-corner-all"  href="javascript:void(0)" onclick="copyQueryLink(\''
								+ url
								+ '\')"><span class="ui-icon ui-icon-copy" title="复制链接"></span></a>'
								+ '<a id="del_query_button_'
								+ i
								+ '" class="ui-state-default ui-corner-all"  href="javascript:void(0)" onclick="delQueryLine(\''
								+ rowId
								+ '\')"><span class="ui-icon ui-icon-trash" title="删除"></span></a>';
						$table.jqGrid('setRowData', rowId, {
							action : operatorButton
						});
					}
				},
				loadComplete : function() {
				},
				beforeSelectRow : function(rowId,e) {
					if(e.type == 'click'){
			              i = $.jgrid.getCellIndex($(e.target).closest('td')[0]),  
			              cm = $table.jqGrid('getGridParam', 'colModel');  
			              return (cm[i].name == 'cb'); //当点击的单元格的名字为cb时，才触发选择行事件
			          }
					return false;
				},
				onPaging : function(pgButton) {
					var curPage = $table.getGridParam('page');
				    var totalPage = $table.getGridParam('lastpage');
				    var pageParam = curPage > totalPage ? totalPage : curPage;
					$table.setGridParam({
						page : pageParam
					});
					return true;
				},
				prmNames : {
					page : 'pageIndex',
					rows : 'pageSize',
					sort : 'sortName',
					order : 'sortOrder',
					search : '_search'
				}
			});
	// 调整宽度
//	$table.setGridWidth($(window).width()*0.6);
//	$table.setGridWidth(document.body.clientWidth*0.6);
	var width = $("#accordion").width();
	$table.setGridWidth(width);
	// 工具栏
	$table.navGrid('#queryGridPager', {
		refresh : false,
		edit : false,
		add : false,
		del : false,
		search : false
	});
	$table.navButtonAdd('#queryGridPager', {
		caption : "批量删除",
		buttonicon : "ui-icon ui-icon-trash",
		onClickButton : function() {
			batchDelQueryLine();
		},
		position : "first"
	});
	$table.on("click", 'tr[role="row"]', function() {
		var id =  $(this).find('td')[2].title;
		var src =  $(this).find('td')[8].title;
		var name =  $(this).find('td')[4].title;
		var img = new Object();
		img.id = id;
		img.src = src;
		img.name = name;
		img.url = JS_HOST + src;
		img.labels = ["aaaa","bbbb","ccc","aaaa","bbbb","ccc","aadafdsafdafdssdasfdsafaa","bbaaaaabb","caaaaaacc","bbaaaaabb","caaaaaacc"];
		showImage(img)
		return true;
	});
}

var isDetailOpen = false;

/**
 * 显示图片
 * @param img
 * @returns
 */
function showImage(img) {
	$("#showImageQuery").attr('src', img.src);
	$("#showImageQuery").attr('title', img.name);
	$("#imageTitle span[tit='icon']").attr("title","展开详情");
	$("#imageTitle span[tit='title']").text(img.id+". "+img.name);
	$("#detailPanel #item-link input").val(img.url);
	
	$("#item-label span[tit='keywords']").children().remove();
	$.each(img.labels,function(i,keyword) {
		var html = '<span tit="keyword">'+keyword+'</span>';
		$("#item-label span[tit='keywords']").append(html);
	});
	
	// 界面控制
	$("#imageTitle span[tit='icon']").addClass("ui-state-default ui-corner-all ui-icon ui-icon-triangle-1-s img-ui-cursor-pointer");
	$("#imageTitle span[tit='title']").css({
		"font-size":"14px",
		"margin-left":"10px"
	});
	//isDetailOpen = false;
	$("#imageTitle [tit='icon']").off("click");
	$("#imageTitle [tit='icon']").click(function(){
		if(!isDetailOpen){
			$("#imageTitle span[tit='icon']").attr("title","收起详情");
			$("#imageTitle span[tit='icon']").removeClass("ui-icon-triangle-1-s");
			$("#imageTitle span[tit='icon']").addClass("ui-icon-triangle-1-n");
			isDetailOpen = true;
		}else{
			$("#imageTitle span[tit='icon']").attr("title","展开详情");
			$("#imageTitle span[tit='icon']").removeClass("ui-icon-triangle-1-n");
			$("#imageTitle span[tit='icon']").addClass("ui-icon-triangle-1-s");
			isDetailOpen = false;
		}
		$("#detailPanel").slideToggle();
	});
}

//从详情中调用拷贝
function copyUrl() {
	var url = $("#detailPanel #item-link input").val();
	$("#remoteUrlSpan").text(url);
	if (!select("remoteUrlSpan")) {
		return;
	}
	document.execCommand("Copy");
	window.getSelection().removeAllRanges();
	SPopupBox.alert("链接已复制到粘贴板");
}

function imageInit() {
	var twidth = document.body.clientWidth*0.4*0.94;
	$("#showImageQuery")[0].width = twidth;
	$("#showImageQuery")[0].height = twidth * 0.75;
	$("#showImageQuery").on("load",function(aa,bb,cc){
		var img = new Image();
		img.src =$(this)[0].src;
		var parentImage = $(this);
		img.onload = function() {
			var twidth = document.body.clientWidth*0.4*0.94
			var width_ = twidth;
			var height_ = twidth * 0.75 ;
			var width = img.width;
			var height = img.height;
			var wh = fitSize(width_,height_,width,height);
			$("#showImageQuery")[0].width = wh[0];
			$("#showImageQuery")[0].height = wh[1];
        }
		function fitSize(widthDst,heightDst,widthImg,heightImg) {
			var tw = widthImg / widthDst;
			var th = heightImg / heightDst;
			var maxFactor = tw > th ? tw : th;
			var rs = new Array();
			rs[0] = widthImg / maxFactor;
			rs[1] = heightImg / maxFactor;
			return rs;
		} 
	});
	
}

/**
 * 拷贝链接
 * 
 * @param remoteUrl
 * @returns
 */
function copyQueryLink(remoteUrl) {
	$("#remoteUrlSpan").text(JS_HOST + remoteUrl);
	if (!select("remoteUrlSpan")) {
		return;
	}
	document.execCommand("Copy");
	window.getSelection().removeAllRanges();
	SPopupBox.alert("链接已复制到粘贴板");
}


var delPostData = new Object();

/**
 * 
 * @param rowId
 * @returns
 */
function delQueryLine(rowId) {
	var row = $queryGrid.jqGrid('getRowData', rowId);
	delPostData.imageId = row.imageId;
	// 回调函数中，无法直接获取外层函数中的临时变量，因此需要用全局变量delPostData来传递参数
	SPopupBox.confirm("确定删除图片：" + row.imageId + " - " + row.name + "?",
			undefined, function() {
				$.ajax({
					url : delImageUrl,
					type : "post",
					data : delPostData,
					dataType : "json",
					success : function(rs) {
						if (rs.success) {
							reloadQueryGrid();
						} else {
							SPopupBox.alert("删除失败:" + rs.message);
						}
					},
					error : function(e) {
						SPopupBox.alert("删除发生异常");
					}
				});
			});
}

var batchDelPostData;
function batchDelQueryLine() {
	var ids = $queryGrid.jqGrid('getGridParam', 'selarrrow');
	if (ids.length < 1) {
		SPopupBox.alert("请勾选需要删除的图片！");
		return;
	}
	if (ids.length > 10) {
		SPopupBox.alert("一次最多删除10条记录！");
		return;
	}
	var keyids = new Array(ids.length);
	var idstr = '';
	$.each(ids, function(i, n) {
		var currentRow = $queryGrid.jqGrid('getRowData', n);
		keyids[i] = currentRow.imageId;
		if (i == 0) {
			idstr = currentRow.imageId;
		} else {
			idstr += "," + currentRow.imageId;
		}
	});
	batchDelPostData = idstr;
	SPopupBox.confirm("确定这批图片?", undefined, function() {
		$.ajax({
			url : batchDelImageUrl,
			type : "post",
			data : {
				"imageIds" : batchDelPostData
			},
			dataType : "json",
			success : function(rs) {
				if (rs.success) {
					reloadQueryGrid();
				} else {
					SPopupBox.alert("删除失败:" + rs.message);
				}
			},
			error : function(e) {
				SPopupBox.alert("删除发生异常");
			}
		});
	});
}

/**
 * 带上查询区的参数
 * @returns
 */
function queryImages() {
	var formJson = $("#searchFrom").serializeObject();
	$queryGrid.clearGridData();
	$queryGrid.jqGrid('setGridParam', {
		postData : formJson
	}).trigger('reloadGrid');
}

/**
 * 重新加载数据，不带任何参数
 * @returns
 */
function reloadQueryGrid() {
	$queryGrid.clearGridData();
	$("#searchFrom")[0].reset();
	$queryGrid.jqGrid("setGridParam", {
		postData : {
		    timeStart:null,
		    timeEnd:null,
		    name:null
		}
	}).trigger("reloadGrid");
}