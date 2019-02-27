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

SQLString1="DROP TABLE office"
SQLString2="CREATE TABLE office ("
SQLString2=SQLString2+"off_id varchar(7) NOT NULL,"
SQLString2=SQLString2+"off_sched_mon varchar(7) REFERENCES doctor (doc_id),"
SQLString2=SQLString2+"off_sched_tue varchar(7) REFERENCES doctor (doc_id),"
SQLString2=SQLString2+"off_sched_wed varchar(7) REFERENCES doctor (doc_id),"
SQLString2=SQLString2+"off_sched_thur varchar(7) REFERENCES doctor (doc_id),"
SQLString2=SQLString2+"off_sched_fri varchar(7) REFERENCES doctor (doc_id),"
SQLString2=SQLString2+"off_sched_sat varchar(7) REFERENCES doctor (doc_id),"
SQLString2=SQLString2+"off_sched_sun varchar(7) REFERENCES doctor (doc_id),"
SQLString2=SQLString2+"off_addr_street varchar(100),"
SQLString2=SQLString2+"off_addr_2 int,"
SQLString2=SQLString2+"off_addr_city varchar(100),"
SQLString2=SQLString2+"off_addr_state varchar(100),"
SQLString2=SQLString2+"off_addr_zip varchar(5),"
SQLString2=SQLString2+"primary key (off_id))"
'
'*** Comment out the following four lines
'     once the table is created remove the comments
'
response.write "<p>Ready to DROP office"
response.write "<p>SQLString --->"+cstr(SQLString1)+"<---"
'cn.execute SQLString1,numa
response.write "<p>DROPPED office OK numa="+cstr(numa)

response.write "<p>Ready to CREATE office"
response.write "<p>SQLString="+cstr(SQLString2)
cn.execute SQLString2,numa
response.write "<p>CREATED office OK numa="+cstr(numa)
%>
<p>
<%
cn.close
set cn=nothing
%>
</body>
</html>