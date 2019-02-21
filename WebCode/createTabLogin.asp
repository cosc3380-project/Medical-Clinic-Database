<html>
<body bgcolor="#cccccc">
<Table border="1">
<tr><td valign='middle' bgcolor='#999999'><img src="captsm.gif"></td>
<td valign='middle' bgcolor='#999999'><center><font color="#ffffff"><font face="Comic Sans MS">
 <br>
 <b>A Simple ASP Example<br>Create/Drop</b> <br>
 
</td></tr></table>
</center>
<p>
<font face="Comic Sans MS"><b>
<p>
<p>Begin execution<p>
<%
'on error resume next
set cn=Server.CreateObject("ADODB.Connection")
cn.open "gl1517","gl1517","MSX44gdnE"

SQLString1="DROP TABLE login"
SQLString2="CREATE TABLE login ("
SQLString2=SQLString2+"log_id varchar(7) NOT NULL,"
SQLString2=SQLString2+"log_pass varchar(50),"
SQLString2=SQLString2+"log_user_id varchar(50),"
SQLString2=SQLString2+"primary key (log_id))"
'
'*** Comment out the following four lines
'     once the table is created remove the comments
'
response.write "<p>Ready to DROP login"
response.write "<p>SQLString --->"+cstr(SQLString1)+"<---"
'cn.execute SQLString1,numa
response.write "<p>DROPPED login OK numa="+cstr(numa)

response.write "<p>Ready to CREATE login"
response.write "<p>SQLString="+cstr(SQLString2)
cn.execute SQLString2,numa
response.write "<p>CREATED login OK numa="+cstr(numa)
%>
<p>
<%
cn.close
set cn=nothing
%>
</body>
</html>