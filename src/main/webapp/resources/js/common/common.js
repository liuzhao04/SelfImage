/**
 * 隔行变色
 * @author yinzf
 * @createtime 2014.11.10
 * @param $table
 */
function tableStriped($table){
	$table.find('tr:even').addClass('even').end()
		  .find('tr:odd').addClass('odd');
}

/**
 * 将表单数据直接转成json
 */
$.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};