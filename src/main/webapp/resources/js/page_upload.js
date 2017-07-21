var $uploadTable = $("#uploadGrid");
var lineIndex = 0;
var selectFileDatas = new Array();

function initTestDatas() {
	var index = datas.length;
	selectFileDatas[index] = new Object();
	selectFileDatas[index].name = "img_1.jpg";
	selectFileDatas[index].localPath = "E:\doc\md\img_1.jpg";
	index = datas.length;
	selectFileDatas[index] = new Object();
	selectFileDatas[index].name = "img_2.jpg";
	selectFileDatas[index].localPath = "E:\doc\md\img_2.jpg";
	index = datas.length;
	selectFileDatas[index] = new Object();
	selectFileDatas[index].name = "img_2.jpg";
	selectFileDatas[index].localPath = "E:\doc\md\img_2.jpg";
	
	for (var i = 0; i < selectFileDatas.length; i++) {
		var lineHtml = addLineStr(selectFileDatas[i]);
		$uploadTable.find("tbody").append(lineHtml);
	}
}

function addLineStr(data) {
	var str = "<tr>";
	addColumnStr(++lineIndex);
	addColumnStr(data.name);
	addColumnStr(data.localPath);
	addColumnStr("进度条");
	addColumnStr("操作");
	return str += "</tr>";
}

function addColumnStr(val, attr) {
	var str = '<td';
	if (attr) {
		str += ' ' + attr;
	}
	return str + "</td>";
}