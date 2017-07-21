$(document).ready(function(){  
    $(".lztable tr").mouseover(function(){$(this).addClass("over");}).mouseout(function(){$(this).removeClass("over");});  
    $(".lztable tr:even").addClass("alt");  
});  