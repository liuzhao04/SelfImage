var initTableUrl = JS_CTX + "/image/initTable.do";

$(document).ready(function() {
	$queryGrid = $("#queryGrid");
	initQueryTable($queryGrid);
});

function initQueryTable($table) {
	$table.jqGrid({
				url : initTableUrl,
				mtype : 'POST',
				loadonce : false,
				datatype : 'json',
				height : '100%',
				shrinkToFit : true,
				colNames : [ 'ImageID','上传批次', '图片名称', '文件大小', '创建时间','操作','远程路径'],
				//cmTemplate: { title: false },
				colModel : [ {
					name : 'imageId',
					hidden:false,
					sortable : false,
					width : 80,
					align : 'center'
				},{
					name : 'batchId',
					width : 250,
					sortable : false,
					align : 'center'
				}, {
					name : 'name',
					index : 'name',
					width : 250,
					align : 'center',
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
					//title : false
				}, {
                    name : 'remoteUrl',
                    hidden: true
                }],
				rowNum : 10,
				rowList : [ 10, 20, 30 ],
				pager : '#queryGridPager',
				gridview : true,
				viewrecords : true,
				postData : {
				},
				jsonReader : {
					root : 'data',
					page : 'pageIndex',
					total : 'pageCount',
					records : 'count',
					repeatitems : false,
					userdata : 'userData'
				},
				gridComplete : function() {
					var indexs = $table.jqGrid('getDataIDs');
					for ( var i = 0; i < indexs.length; i++) {
						var rowId = indexs[i];
						var currentRow = $table.jqGrid('getRowData', rowId);
						var url = currentRow.remoteUrl.replace(/\\/g,'/');
						var operatorButton = '<a id="copy_query_button_' + i + '" class="ui-state-default ui-corner-all"  href="javascript:void(0)" onclick="copyQueryLink(\''+url+'\')"><span class="ui-icon ui-icon-copy" title="复制链接"></span></a>'
						+'<a id="del_query_button_' + i + '" class="ui-state-default ui-corner-all"  href="javascript:void(0)" onclick="delQueryLine(\''+i+'\')"><span class="ui-icon ui-icon-trash" title="删除"></span></a>';
						$table.jqGrid('setRowData', rowId, {
							action : operatorButton
						});
					}
				},
				loadComplete : function() {
				},
				beforeSelectRow : function(rowId) {
				    var currentRow = $table.jqGrid('getRowData', rowId);
				    if(currentRow.remoteUrl) {
				        $("#showImageQuery").attr('src',currentRow.remoteUrl); 
				        $("#showImageQuery").attr('title',currentRow.name); 
				    }
				    return true;
				},
				onPaging : function(pgButton) {
					var curPage = $table.getGridParam('page'), totalPage = $table
							.getGridParam('lastpage'), pageParam = curPage > totalPage ? totalPage
							: curPage;
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
}

function copyQueryLink(remoteUrl) {
    debugger
    $("#remoteUrlSpan").text(JS_HOST+remoteUrl);
    if (!select("remoteUrlSpan")) {
        return;
    }
    document.execCommand("Copy");
    window.getSelection().removeAllRanges();
    SPopupBox.alert("链接已复制到粘贴板");
}