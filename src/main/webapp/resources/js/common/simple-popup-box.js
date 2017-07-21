
/**
 * 简单弹出框工具
 */
var SPopupBox = function(){};

SPopupBox.alertDiv = "SPopupBox_Alert_Div";
SPopupBox.$box_alert;

SPopupBox.alert = function(message,title,width,height) {
	var width_ = width;
	var height_ = height;
	var title_ = title;
	if(!width_) {
		width_ = 400;
	}
	if(!height_) {
		height_ = 200;
	}
	if(!title_) {
		title_ = "系统提示";
	}
	if(!SPopupBox.$box_alert){
		$('body').append("<div id='"+SPopupBox.alertDiv+"'><p></p></div>")
		SPopupBox.$box_alert = $("#"+SPopupBox.alertDiv);
		SPopupBox.$box_alert.dialog({
			autoOpen: false,
			width: width_,
			height: height_,
			title:title_,
			buttons: [
				{
					text: "确定",
					click: function() {
						$( this ).dialog( "close" );
					}
				}
			]
		});
	}
	SPopupBox.$box_alert.find("p").text(message);
	SPopupBox.$box_alert.dialog( "open" );
};


SPopupBox.confirmDiv = "SPopupBox_Confirm_Div";
SPopupBox.$box_confirm;

SPopupBox.confirm = function(message,title,callback,width,height) {
	var width_ = width;
	var height_ = height;
	var title_ = title;
	if(!width_) {
		width_ = 400;
	}
	if(!height_) {
		height_ = 200;
	}
	if(!title_) {
		title_ = "系统提示";
	}
	var cancle = false;
	if(!SPopupBox.$box_confirm){
		$('body').append("<div id='"+SPopupBox.confirmDiv+"'><p></p></div>")
		SPopupBox.$box_confirm = $("#"+SPopupBox.confirmDiv);
		SPopupBox.$box_confirm.dialog({
			autoOpen: false,
			width: width_,
			height: height_,
			title:title_,
			buttons: [
				{
					text: "确定",
					click: function() {
						$( this ).dialog( "close" );
						if(callback){
							callback();
						}
					}
				},{
					text: "取消",
					click: function() {
						$( this ).dialog( "close" );
					}
				}
			]
		});
	}
	SPopupBox.$box_confirm.find("p").text(message);
	SPopupBox.$box_confirm.dialog( "open" );
};