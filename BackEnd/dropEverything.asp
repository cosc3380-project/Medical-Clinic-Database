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
on error resume next
set cn=Server.CreateObject("ADODB.Connection")
cn.open "gl1517","gl1517","MSX44gdnE"

SQLString1="DROP TABLE login"
response.write "<p>Ready to DROP login"
response.write "<p>SQLString --->"+cstr(SQLString1)+"<---"
cn.execute SQLString1,numa
response.write "<p>DROPPED login OK numa="+cstr(numa)

SQLString1="DROP TABLE prescription"
response.write "<p>Ready to DROP prescription"
response.write "<p>SQLString --->"+cstr(SQLString1)+"<---"
cn.execute SQLString1,numa
response.write "<p>DROPPED prescription OK numa="+cstr(numa)

SQLString1="DROP TABLE diagnosis"
response.write "<p>Ready to DROP diagnosis"
response.write "<p>SQLString --->"+cstr(SQLString1)+"<---"
cn.execute SQLString1,numa
response.write "<p>DROPPED diagnosis OK numa="+cstr(numa)

SQLString1="DROP TABLE approval"
response.write "<p>Ready to DROP approval"
response.write "<p>SQLString --->"+cstr(SQLString1)+"<---"
cn.execute SQLString1,numa
response.write "<p>DROPPED approval OK numa="+cstr(numa)

SQLString1="DROP TABLE appointment"
response.write "<p>Ready to DROP appointment"
response.write "<p>SQLString --->"+cstr(SQLString1)+"<---"
cn.execute SQLString1,numa
response.write "<p>DROPPED appointment OK numa="+cstr(numa)

SQLString1="DROP TABLE email"
response.write "<p>Ready to DROP email"
response.write "<p>SQLString --->"+cstr(SQLString1)+"<---"
cn.execute SQLString1,numa
response.write "<p>DROPPED email OK numa="+cstr(numa)

SQLString1="DROP TABLE office_admin"
response.write "<p>Ready to DROP office_admin"
response.write "<p>SQLString --->"+cstr(SQLString1)+"<---"
cn.execute SQLString1,numa
response.write "<p>DROPPED office_admin OK numa="+cstr(numa)

SQLString1="DROP TABLE patient"
response.write "<p>Ready to DROP patient"
response.write "<p>SQLString --->"+cstr(SQLString1)+"<---"
cn.execute SQLString1,numa
response.write "<p>DROPPED patient OK numa="+cstr(numa)

SQLString1="DROP TABLE office"
response.write "<p>Ready to DROP office"
response.write "<p>SQLString --->"+cstr(SQLString1)+"<---"
cn.execute SQLString1,numa
response.write "<p>DROPPED office OK numa="+cstr(numa)

SQLString1="DROP TABLE blood_test"
response.write "<p>Ready to DROP blood_test"
response.write "<p>SQLString --->"+cstr(SQLString1)+"<---"
cn.execute SQLString1,numa
response.write "<p>DROPPED blood_test OK numa="+cstr(numa)

SQLString1="DROP TABLE doctor"
response.write "<p>Ready to DROP doctor"
response.write "<p>SQLString --->"+cstr(SQLString1)+"<---"
cn.execute SQLString1,numa
response.write "<p>DROPPED doctor OK numa="+cstr(numa)
%>
<p>
<%
cn.close
set cn=nothing
%>
</body>
</html>