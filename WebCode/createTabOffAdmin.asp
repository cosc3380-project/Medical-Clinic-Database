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

SQLString1="DROP TABLE office_admin"
SQLString2="CREATE TABLE office_admin ("
SQLString2=SQLString2+"oa_id varchar(7) NOT NULL,"
SQLString2=SQLString2+"oa_role varchar(100),"
SQLString2=SQLString2+"oa_firstname varchar(100),"
SQLString2=SQLString2+"oa_lastname varchar(100),"
SQLString2=SQLString2+"oa_gender char(1),"
SQLString2=SQLString2+"oa_email varchar(100),"
SQLString2=SQLString2+"oa_dob date,"
SQLString2=SQLString2+"oa_addr_street varchar(100),"
SQLString2=SQLString2+"oa_addr_2 int,"
SQLString2=SQLString2+"oa_addr_city varchar(100),"
SQLString2=SQLString2+"oa_addr_state varchar(100),"
SQLString2=SQLString2+"oa_addr_zip varchar(5),"
SQLString2=SQLString2+"primary key (oa_id))"
'
'*** Comment out the following four lines
'     once the table is created remove the comments
'
response.write "<p>Ready to DROP office_admin"
response.write "<p>SQLString --->"+cstr(SQLString1)+"<---"
'cn.execute SQLString1,numa
response.write "<p>DROPPED office_admin OK numa="+cstr(numa)

response.write "<p>Ready to CREATE office_admin"
response.write "<p>SQLString="+cstr(SQLString2)
cn.execute SQLString2,numa
response.write "<p>CREATED office_admin OK numa="+cstr(numa)
%>
<p>
<%
cn.close
set cn=nothing
%>
</body>
</html>