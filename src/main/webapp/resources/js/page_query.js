var initTableUrl = JS_CTX + "/image/initTable.do";

$(document).ready(function() {
	debugger
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
				colNames : [ 'ImageID','上传批次', '图片名称', '文件大小', '创建时间','操作'],
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
					sortable : true
				}, {
					name : 'action',
					width : 100,
					//title : false
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
					total : 'pageSize',
					records : 'count',
					repeatitems : false,
					userdata : 'userData'
				},
				gridComplete : function() {
					var indexs = $table.jqGrid('getDataIDs');
					for ( var i = 0; i < indexs.length; i++) {
						var rowId = indexs[i];
						var currentRow = $table.jqGrid('getRowData', rowId);
						
//						$table.jqGrid('setRowData', rowId, {
//							action : operatorButton
//						});

					}
				},
				loadComplete : function() {
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