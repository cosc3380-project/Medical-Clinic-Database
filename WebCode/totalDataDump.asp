<HTML>
<BODY>
Total System Information Dump

<%
Set rs = Server.CreateObject("ADODB.Recordset")
sql_string="Select * from patient"

response.write "<p>SQL--->"+sql_string+"<---<p>"
rs.open sql_string, "DSN=gl1517;UID=gl1517;PWD=MSX44gdnE;"

response.write "<p><table border='1'><tr>"

for i = 0 to rs.fields.count - 1
  response.write "<td align='center'>"+cstr(rs(i).Name)+"</td>"
next
response.write "</tr>"
row_count=0
while not rs.EOF
  row_count=row_count+1
  response.write "<tr>"
  for i = 0 to rs.fields.count - 1
     response.write "<td align='right'>"+cstr(rs(i))+"</td>"
  next
  response.write "</tr>"
  rs.MoveNext
wend

response.write "</table><p>Row Count="+cstr(row_count)
response.write "<p>Normal Termination "+cstr(now)
rs.Close
set rs=nothing
%>

<br><hr><br>

<%
Set rs = Server.CreateObject("ADODB.Recordset")
sql_string="Select * from doctor"

response.write "<p>SQL--->"+sql_string+"<---<p>"
rs.open sql_string, "DSN=gl1517;UID=gl1517;PWD=MSX44gdnE;"

response.write "<p><table border='1'><tr>"

for i = 0 to rs.fields.count - 1
  response.write "<td align='center'>"+cstr(rs(i).Name)+"</td>"
next
response.write "</tr>"
row_count=0
while not rs.EOF
  row_count=row_count+1
  response.write "<tr>"
  for i = 0 to rs.fields.count - 1
     response.write "<td align='right'>"+cstr(rs(i))+"</td>"
  next
  response.write "</tr>"
  rs.MoveNext
wend

response.write "</table><p>Row Count="+cstr(row_count)
response.write "<p>Normal Termination "+cstr(now)
rs.Close
set rs=nothing
%>

<br><hr><br>

<%
Set rs = Server.CreateObject("ADODB.Recordset")
sql_string="Select * from office"

response.write "<p>SQL--->"+sql_string+"<---<p>"
rs.open sql_string, "DSN=gl1517;UID=gl1517;PWD=MSX44gdnE;"

response.write "<p><table border='1'><tr>"

for i = 0 to rs.fields.count - 1
  response.write "<td align='center'>"+cstr(rs(i).Name)+"</td>"
next
response.write "</tr>"
row_count=0
while not rs.EOF
  row_count=row_count+1
  response.write "<tr>"
  for i = 0 to rs.fields.count - 1
     response.write "<td align='right'>"+cstr(rs(i))+"</td>"
  next
  response.write "</tr>"
  rs.MoveNext
wend

response.write "</table><p>Row Count="+cstr(row_count)
response.write "<p>Normal Termination "+cstr(now)
rs.Close
set rs=nothing
%>

<br><hr><br>

<%
Set rs = Server.CreateObject("ADODB.Recordset")
sql_string="Select * from office_admin"

response.write "<p>SQL--->"+sql_string+"<---<p>"
rs.open sql_string, "DSN=gl1517;UID=gl1517;PWD=MSX44gdnE;"

response.write "<p><table border='1'><tr>"

for i = 0 to rs.fields.count - 1
  response.write "<td align='center'>"+cstr(rs(i).Name)+"</td>"
next
response.write "</tr>"
row_count=0
while not rs.EOF
  row_count=row_count+1
  response.write "<tr>"
  for i = 0 to rs.fields.count - 1
     response.write "<td align='right'>"+cstr(rs(i))+"</td>"
  next
  response.write "</tr>"
  rs.MoveNext
wend

response.write "</table><p>Row Count="+cstr(row_count)
response.write "<p>Normal Termination "+cstr(now)
rs.Close
set rs=nothing
%>

<br><hr><br>

<%
Set rs = Server.CreateObject("ADODB.Recordset")
sql_string="Select * from appointment"

response.write "<p>SQL--->"+sql_string+"<---<p>"
rs.open sql_string, "DSN=gl1517;UID=gl1517;PWD=MSX44gdnE;"

response.write "<p><table border='1'><tr>"

for i = 0 to rs.fields.count - 1
  response.write "<td align='center'>"+cstr(rs(i).Name)+"</td>"
next
response.write "</tr>"
row_count=0
while not rs.EOF
  row_count=row_count+1
  response.write "<tr>"
  for i = 0 to rs.fields.count - 1
     response.write "<td align='right'>"+cstr(rs(i))+"</td>"
  next
  response.write "</tr>"
  rs.MoveNext
wend

response.write "</table><p>Row Count="+cstr(row_count)
response.write "<p>Normal Termination "+cstr(now)
rs.Close
set rs=nothing
%>

<br><hr><br>

<%
Set rs = Server.CreateObject("ADODB.Recordset")
sql_string="Select * from approval"

response.write "<p>SQL--->"+sql_string+"<---<p>"
rs.open sql_string, "DSN=gl1517;UID=gl1517;PWD=MSX44gdnE;"

response.write "<p><table border='1'><tr>"

for i = 0 to rs.fields.count - 1
  response.write "<td align='center'>"+cstr(rs(i).Name)+"</td>"
next
response.write "</tr>"
row_count=0
while not rs.EOF
  row_count=row_count+1
  response.write "<tr>"
  for i = 0 to rs.fields.count - 1
     response.write "<td align='right'>"+cstr(rs(i))+"</td>"
  next
  response.write "</tr>"
  rs.MoveNext
wend

response.write "</table><p>Row Count="+cstr(row_count)
response.write "<p>Normal Termination "+cstr(now)
rs.Close
set rs=nothing
%>

<br><hr><br>

<%
Set rs = Server.CreateObject("ADODB.Recordset")
sql_string="Select * from diagnosis"

response.write "<p>SQL--->"+sql_string+"<---<p>"
rs.open sql_string, "DSN=gl1517;UID=gl1517;PWD=MSX44gdnE;"

response.write "<p><table border='1'><tr>"

for i = 0 to rs.fields.count - 1
  response.write "<td align='center'>"+cstr(rs(i).Name)+"</td>"
next
response.write "</tr>"
row_count=0
while not rs.EOF
  row_count=row_count+1
  response.write "<tr>"
  for i = 0 to rs.fields.count - 1
     response.write "<td align='right'>"+cstr(rs(i))+"</td>"
  next
  response.write "</tr>"
  rs.MoveNext
wend

response.write "</table><p>Row Count="+cstr(row_count)
response.write "<p>Normal Termination "+cstr(now)
rs.Close
set rs=nothing
%>

<br><hr><br>

<%
Set rs = Server.CreateObject("ADODB.Recordset")
sql_string="Select * from prescription"

response.write "<p>SQL--->"+sql_string+"<---<p>"
rs.open sql_string, "DSN=gl1517;UID=gl1517;PWD=MSX44gdnE;"

response.write "<p><table border='1'><tr>"

for i = 0 to rs.fields.count - 1
  response.write "<td align='center'>"+cstr(rs(i).Name)+"</td>"
next
response.write "</tr>"
row_count=0
while not rs.EOF
  row_count=row_count+1
  response.write "<tr>"
  for i = 0 to rs.fields.count - 1
     response.write "<td align='right'>"+cstr(rs(i))+"</td>"
  next
  response.write "</tr>"
  rs.MoveNext
wend

response.write "</table><p>Row Count="+cstr(row_count)
response.write "<p>Normal Termination "+cstr(now)
rs.Close
set rs=nothing
%>

<br><hr><br>

<%
Set rs = Server.CreateObject("ADODB.Recordset")
sql_string="Select * from login"

response.write "<p>SQL--->"+sql_string+"<---<p>"
rs.open sql_string, "DSN=gl1517;UID=gl1517;PWD=MSX44gdnE;"

response.write "<p><table border='1'><tr>"

for i = 0 to rs.fields.count - 1
  response.write "<td align='center'>"+cstr(rs(i).Name)+"</td>"
next
response.write "</tr>"
row_count=0
while not rs.EOF
  row_count=row_count+1
  response.write "<tr>"
  for i = 0 to rs.fields.count - 1
     response.write "<td align='right'>"+cstr(rs(i))+"</td>"
  next
  response.write "</tr>"
  rs.MoveNext
wend

response.write "</table><p>Row Count="+cstr(row_count)
response.write "<p>Normal Termination "+cstr(now)
rs.Close
set rs=nothing
%>

<br><hr><br>

</BODY>
</HTML>