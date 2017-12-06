<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
                    class="table_padding">
                 <tr>
                     <td width="8%" class="font_left">数据:<span id="total"></span>条</td>
                     <td width="12" class="font_left">第</td>
                     <td width="135" class="font_left">
                         <input id="pageNo" type="text" size="2" maxlength="4" /> /<span id="pageCount"></span> 页
                     </td>
                     <td class="font_left">
                     	<select id="pageSize" onchange="displayData(0);">
                     		<option value="2">每页2条</option>
                     		<option value="3">每页3条</option>
                     		<option value="4">每页4条</option>
                     	</select>
                     </td>
                     <td width="478" class="font_right">
                       <div id="pagination"></div>
                     </td>
                 </tr>
             </table>