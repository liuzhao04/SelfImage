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