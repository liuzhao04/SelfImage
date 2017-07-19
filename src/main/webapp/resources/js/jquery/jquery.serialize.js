
$.fn.extend({       // 扩展jquery form Serialize 方法，解决IE浏览器传输中文后台接受乱码问题（两次encodeURIComponent编码，后台需调用java.net.URLDecoder.decode进行解码）
	"chiSerialize": function () {  
		return jQuery.chiParam( this.serializeArray() );
	}
});
var r20 = /%20/g;
jQuery.extend({
	"chiParam": function( a, traditional ) {
		var s = [],
			add = function( key, value ) {
				// If value is a function, invoke it and return its value
				value = jQuery.isFunction( value ) ? value() : value;
				s[ s.length ] = encodeURIComponent(encodeURIComponent( key )) + "=" + encodeURIComponent(encodeURIComponent( value ));
			};

		// Set traditional to true for jQuery <= 1.3.2 behavior.
		if ( traditional === undefined ) {
			traditional = jQuery.ajaxSettings.traditional;
		}

		// If an array was passed in, assume that it is an array of form elements.
		if ( jQuery.isArray( a ) || ( a.jquery && !jQuery.isPlainObject( a ) ) ) {
			// Serialize the form elements
			jQuery.each( a, function() {
				add( this.name, this.value );
			});

		} else {
			// If traditional, encode the "old" way (the way 1.3.2 or older
			// did it), otherwise encode params recursively.
			for ( var prefix in a ) {
				buildParams( prefix, a[ prefix ], traditional, add );
			}
		}

		// Return the resulting serialization
		return s.join( "&" ).replace( r20, "+" );
	}
	
});




$.fn.extend({       // 扩展jquery form Serialize 方法，解决checkbox未选中状态下未能获得checkbox value的问题
		"fixedSerialize": function () {  
			var $f = $(this);  
			
			var $textA = $(this).find("textarea");
			if($textA.length!=0){
				$textA.each(function(){
					var c = "";
					var result = "";
					var value = $(this).val();
					for(var i=0; i<value.length; i++){
						c = value.substr(i, 1);
						if (c == "\n"){
							result = result + " ";
						} else if(c != "\r"){
							result = result + c;
						}
					}
					$(this).attr("value", result);
				});
			}
			
			var data = $(this).serialize();  
			
			var $chks = $(this).find(":checkbox:not(:checked)");    //取得所有未选中的checkbox  
			
			var $date = $(this).find(":input[title='date']");
			
			if($date.length!=0){
				$date.each(function(){
					var dateName = $(this).attr("name");
					var dateVal = $(this).val();
					if(dateVal==""){
						dateName = "&"+dateName+"=";
						data = data.replace(dateName, "");
					}
				});
			}

			if ($chks.length == 0) {  
				return data;  
			}  
			var nameArr = [];  
			var tempStr = "";  
			$chks.each(function () {  
				var chkName = $(this).attr("name");   
				var chkVal = $(this).val();
				if ($.inArray(chkName, nameArr) == -1 && $f.find(":checkbox[name='" + chkName + "']:checked").length == 0) {  
					nameArr.push(chkName);  
					tempStr += "&" + chkName + "=" + chkVal;  
				}  
			});  
			data += tempStr;  
			return data;  
		},
		isBlank : function(){
			var value = $(this).val();
			if(typeof value == undefined || value == undefined || value == null || value == ""){
				return true;
			}
			return false;
		},
		isNotBlank : function(value){
			var value = $(this).val();
			if(typeof value == undefined || value == undefined || value == null || value == ""){
				return false;
			}
			return true;
		}
});