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

SQLString1="DROP TABLE prescription"
SQLString2="CREATE TABLE prescription ("
SQLString2=SQLString2+"pre_id varchar(7) NOT NULL,"
SQLString2=SQLString2+"pre_appt_id varchar(7) REFERENCES appointment (appt_id),"
SQLString2=SQLString2+"pre_name varchar(50),"
SQLString2=SQLString2+"pre_refills_allowed int,"
SQLString2=SQLString2+"pre_refills_filled int,"
SQLString2=SQLString2+"primary key (pre_id))"
'
'*** Comment out the following four lines
'     once the table is created remove the comments
'
response.write "<p>Ready to DROP prescription"
response.write "<p>SQLString --->"+cstr(SQLString1)+"<---"
'cn.execute SQLString1,numa
response.write "<p>DROPPED prescription OK numa="+cstr(numa)

response.write "<p>Ready to CREATE prescription"
response.write "<p>SQLString="+cstr(SQLString2)
cn.execute SQLString2,numa
response.write "<p>CREATED prescription OK numa="+cstr(numa)
%>
<p>
<%
cn.close
set cn=nothing
%>
</body>
</html>