var $uploadTable;
var selectFileDatas = new Array();

function initTestDatas()
{
    var index = selectFileDatas.length;
    selectFileDatas[index] = new Object();
    selectFileDatas[index].name = "img_1.jpg";
    selectFileDatas[index].remoteUrl = "resources/images/test1.jpg";
    selectFileDatas[index].fileSize = 536;
    index = selectFileDatas.length;
    selectFileDatas[index] = new Object();
    selectFileDatas[index].name = "img_2.jpg";
    selectFileDatas[index].remoteUrl = "resources/images/test1.jpg";
    selectFileDatas[index].fileSize = 1000;
    index = selectFileDatas.length;
    selectFileDatas[index] = new Object();
    selectFileDatas[index].name = "img_3.jpg";
    selectFileDatas[index].remoteUrl = "resources/images/test1.jpg";
    selectFileDatas[index].fileSize = 1235;
    refreshTable();
}

function init(data) {
    selectFileDatas = data;
    refreshTable();
}

function process(data) {
    var i = 0;
    $.each(selectFileDatas,function(i,row){
        var tmp = undefined;
        $.each(data,function(j,row_){
            if(row_.name == row.name) {
                tmp = row_;
            }
        });
        if(tmp) {
            var percent = GetPercent(tmp.uploadSize, tmp.fileSize);
            var txt = percent + "% " + Math.round(tmp.uploadSize / 1024)+"k/"+Math.round(tmp.fileSize / 1024)+"k";
            changeProcess(i, percent, txt);
            return;
        }
        i++;
    });
}

function refreshTable()
{
    if (!$uploadTable)
    {
        $uploadTable = $("#uploadGrid");
    }
    $uploadTable.find("tbody").children().remove();
    var i = 0;
    $.each(selectFileDatas, function(index, value)
    {
        var lineHtml = addLineStr(i, value);
        $uploadTable.find("tbody").append(lineHtml);
        addProccessBar(i++);
    });
    lztableStyle();
}

function changeImage(i) {
    var data = getRowData(i);
    if(data && data.remoteUrl) {
        $("#showImage").attr('src',data.remoteUrl); 
        $("#showImage").attr('title',data.name); 
    }
}

function getRowData(i) {
    var tmpIndex = 0;
    var pos = -1;
    $.each(selectFileDatas, function(index, value){
        if (tmpIndex++ == i) {
            pos = index;
            return;
        }
    });
    if(pos != -1) {
        return selectFileDatas[pos];
    }
    return undefined;
}

function copyLink(i) {
    var data = getRowData(i);
    $("#remoteUrlSpan").text(JS_HOST+data.remoteUrl);
    if (!select("remoteUrlSpan")) {
        return;
    }
    document.execCommand("Copy");
    window.getSelection().removeAllRanges();
    SPopupBox.alert("已复制到粘贴板");
}

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

var delIndex = -1;
function delLine(i)
{
    var data = getRowData(i);
    delIndex = i;
    SPopupBox.confirm("确定删除已选择的图片:" + data.name + "?", undefined, function()
    {
        var tmpIndex = 0;
        var pos = -1;
        $.each(selectFileDatas, function(index, value){
            if (tmpIndex++ == delIndex) {
                pos = index;
                return;
            }
        });
        if (pos != -1)
        {
            selectFileDatas.splice(pos, 1);
            refreshTable();
        }
    });
    return false;
}

function addLineStr(i, data)
{
    var str = "<tr onclick='changeImage("+i+")'>";
    str += addColumnStr(i+1);
    str += addColumnStr(data.name,"class='img_name'");
    //str += addColumnStr(data.remoteUrl);
    var processtxt = "0% 0k/" + Math.round(data.fileSize/1024) + "k";
    str +=
        addColumnStr("<span class='process' id='progressbar_" + i + "'></span><span id='progresstxt_" + i + "'>"
            + processtxt + "</span>");
    var delButton =
        '<span id="del_button_' + i
            + '" class="ui-state-default ui-corner-all"  href="javascript:void(0)" onclick="copyLink('+i+')"><span class="ui-icon ui-icon-copy" title="复制链接"></span></span>';
    str += addColumnStr(delButton);
    return str += "</tr>";
}

function changeProcess(i, value, txt)
{
    $("#progressbar_" + i).progressbar(
    {
        value : value
    });
    $("#progresstxt_" + i).text(txt);
}

function addProccessBar(i)
{
    $("#progressbar_" + i).progressbar(
    {
        value : 0
    });
}

function addColumnStr(val, attr)
{
    var str = '<td';
    if (attr)
    {
        str += ' ' + attr;
    }
    str += '>' + val;
    return str + "</td>";
}

function GetPercent(num, total) { 
    num = parseFloat(num); 
    total = parseFloat(total); 
    if (isNaN(num) || isNaN(total)) { 
        return "-"; 
    } 
    return total <= 0 ? 0 : (Math.round(num / total * 100)); 
    } 