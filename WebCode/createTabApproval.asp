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

SQLString1="DROP TABLE approval"
SQLString2="CREATE TABLE approval ("
SQLString2=SQLString2+"app_id varchar(7) NOT NULL,"
SQLString2=SQLString2+"app_doc_id varchar(7) REFERENCES doctor (doc_id),"
SQLString2=SQLString2+"app_pat_id varchar(7) REFERENCES patient (pat_id),"
SQLString2=SQLString2+"app_spec_id varchar(7) REFERENCES office (off_id),"
SQLString2=SQLString2+"app_given bit,"
SQLString2=SQLString2+"primary key (app_id))"
'
'*** Comment out the following four lines
'     once the table is created remove the comments
'
response.write "<p>Ready to DROP approval"
response.write "<p>SQLString --->"+cstr(SQLString1)+"<---"
'cn.execute SQLString1,numa
response.write "<p>DROPPED approval OK numa="+cstr(numa)

response.write "<p>Ready to CREATE approval"
response.write "<p>SQLString="+cstr(SQLString2)
cn.execute SQLString2,numa
response.write "<p>CREATED approval OK numa="+cstr(numa)
%>
<p>
<%
cn.close
set cn=nothing
%>
</body>
</html>