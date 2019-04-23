<html>
<body>
<table style="width:100%">
	<tr>
		<td style="width:33%;text-align:left">
			<a href='/students/gl1517/cosc3380/index.html'>COSC 3380 Project Homepage - StarCare Medical Clinic</a>
		</td>
		<td style="width:33%;text-align:center">
			Loading tables with data...
		</td>
		<td style="width:33%;text-align:right">
			<a href='http://auckland.bauer.uh.edu/students/gl1517/'>JW's Homepage</a>
		</td>
	</tr>
</table><hr>
<p>

<p>
<p>Begin execution<p>
<%
'on error resume next
set cn=Server.CreateObject("ADODB.Connection")
cn.open "gl1517","gl1517","MSX44gdnE"

'Patient Table------------------------------------------------------------------------------------------------

numa=0
SQLString="INSERT INTO patient "
SQLString=SQLString + "(Pat_Name_F, Pat_Name_L, Pat_Height, Pat_Weight, Pat_Gender, Pat_Email, Pat_Phone, Pat_DOB, Pat_Addr_Street, Pat_Addr_City, Pat_Addr_State, Pat_Addr_Zip, Pat_Created_By, Pat_Created_Date, Pat_Updated_By)"
SQLString=SQLString + " VALUES ('John', 'Smith', 69, 135, 'M', 'john.smith@gmail.com', '1111111111', cast(cast(1995*10000 + 07*100 + 21 as varchar(255)) as date), '3100 Main St', 'Houston', 'TX', 77009, 'Self', cast(cast(2019*10000 + 04*100 + 11 as varchar(255)) as date), 'none')"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if


numa=0
SQLString="INSERT INTO patient "
SQLString=SQLString + "(Pat_Name_F, Pat_Name_L, Pat_Height, Pat_Weight, Pat_Gender, Pat_Email, Pat_Phone, Pat_DOB, Pat_Addr_Street, Pat_Addr_City, Pat_Addr_State, Pat_Addr_Zip, Pat_Created_By, Pat_Created_Date, Pat_Updated_By)"
SQLString=SQLString + " VALUES ('Jane', 'Smith', 65, 130, 'F', 'jane.smith@gmail.com', '1111111111', cast(cast(1994*10000 + 08*100 + 05 as varchar(255)) as date), '3100 Main St', 'Houston', 'TX', 77009, 'Self', cast(cast(2019*10000 + 04*100 + 11 as varchar(255)) as date), 'none')"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if


numa=0
SQLString="INSERT INTO patient "
SQLString=SQLString + "(Pat_Name_F, Pat_Name_L, Pat_Height, Pat_Weight, Pat_Gender, Pat_Email, Pat_Phone, Pat_DOB, Pat_Addr_Street, Pat_Addr_2, Pat_Addr_City, Pat_Addr_State, Pat_Addr_Zip, Pat_Created_By, Pat_Created_Date, Pat_Updated_By)"
SQLString=SQLString + " VALUES ('Alex', 'Craft', 76, 130, 'F', 'alex@microsoft.com', '1111111111', cast(cast(1976*10000 + 02*100 + 13 as varchar(255)) as date), '1 Diamond Rd.', 'A', 'Houston', 'TX', 77092, 'Self', cast(cast(2019*10000 + 04*100 + 11 as varchar(255)) as date), 'none')"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO patient "
SQLString=SQLString + "(Pat_Name_F, Pat_Name_L, Pat_Height, Pat_Weight, Pat_Gender, Pat_Email, Pat_Phone, Pat_DOB, Pat_Addr_Street, Pat_Addr_2, Pat_Addr_City, Pat_Addr_State, Pat_Addr_Zip, Pat_Created_By, Pat_Created_Date, Pat_Updated_By)"
SQLString=SQLString + " VALUES ('Steve', 'Craft', 76, 130, 'M', 'steve@microsoft.com', '1111111111', cast(cast(1976*10000 + 02*100 + 13 as varchar(255)) as date), '1 Diamond Rd.', 'B', 'Houston', 'TX', 77092, 'Self', cast(cast(2019*10000 + 04*100 + 11 as varchar(255)) as date), 'none')"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO patient "
SQLString=SQLString + "(Pat_Name_F, Pat_Name_L, Pat_Height, Pat_Weight, Pat_Gender, Pat_Email, Pat_Phone, Pat_DOB, Pat_Addr_Street, Pat_Addr_2, Pat_Addr_City, Pat_Addr_State, Pat_Addr_Zip, Pat_Created_By, Pat_Created_Date, Pat_Updated_By, Pat_Deleted)"
SQLString=SQLString + " VALUES ('Herobrine', 'Craft', 76, 130, 'M', 'herob@microsoft.com', '1111111111', cast(cast(1976*10000 + 02*100 + 13 as varchar(255)) as date), '1 Diamond Rd.', 'B', 'Houston', 'TX', 77092, 'Self', cast(cast(2019*10000 + 04*100 + 11 as varchar(255)) as date), 'none', 1)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO patient "
SQLString=SQLString + "(Pat_Name_F, Pat_Name_L, Pat_Height, Pat_Weight, Pat_Gender, Pat_Email, Pat_Phone, Pat_DOB, Pat_Addr_Street, Pat_Addr_City, Pat_Addr_State, Pat_Addr_Zip, Pat_Created_By, Pat_Created_Date, Pat_Updated_By)"
SQLString=SQLString + " VALUES ('Mario', 'Mario', 61, 130, 'M', 'mario@nintendo.com', '1111111111', cast(cast(1985*10000 + 09*100 + 13 as varchar(255)) as date), '23 Mushroom Way', 'Houston', 'TX', 77004, 'Self', cast(cast(2019*10000 + 04*100 + 11 as varchar(255)) as date), 'none')"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO patient "
SQLString=SQLString + "(Pat_Name_F, Pat_Name_L, Pat_Height, Pat_Weight, Pat_Gender, Pat_Email, Pat_Phone, Pat_DOB, Pat_Addr_Street, Pat_Addr_City, Pat_Addr_State, Pat_Addr_Zip, Pat_Created_By, Pat_Created_Date, Pat_Updated_By)"
SQLString=SQLString + " VALUES ('Luigi', 'Mario', 65, 120, 'M', 'luigi@nintendo.com', '1111111111', cast(cast(1985*10000 + 09*100 + 13 as varchar(255)) as date), '23 Mushroom Way', 'Houston', 'TX', 77004, 'Self', cast(cast(2019*10000 + 04*100 + 11 as varchar(255)) as date), 'none')"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO patient "
SQLString=SQLString + "(Pat_Name_F, Pat_Name_L, Pat_Height, Pat_Weight, Pat_Gender, Pat_Email, Pat_Phone, Pat_DOB, Pat_Addr_Street, Pat_Addr_City, Pat_Addr_State, Pat_Addr_Zip, Pat_Created_By, Pat_Created_Date, Pat_Updated_By)"
SQLString=SQLString + " VALUES ('Patrick', 'Star', '100', '120', 'M', 'patrick.star@gmail.com', '1112223333', cast(cast(1985*10000 + 09*100 + 13 as varchar(255)) as date), '1234 Fake Street', 'Fulshear', 'TX', 12345, 'Self', cast(cast(2019*10000 + 04*100 + 11 as varchar(255)) as date), 'none')"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

'Doctor Table------------------------------------------------------------------------------------------------

numa=0
SQLString="INSERT INTO doctor "
SQLString=SQLString + "(Doc_Name_F, Doc_Name_L, Doc_Specialization, Doc_Gender, Doc_Email, Doc_Phone, Doc_DOB, Doc_Addr_Street, Doc_Addr_City, Doc_Addr_State, Doc_Addr_Zip, Doc_Deleted)"
SQLString=SQLString + " VALUES ('William', 'Knighton', 'General Doctor', 'M', 'w.knighton@starcare.com', '5431287931', cast(cast(1965*10000 + 02*100 + 25 as varchar(255)) as date), '370 Kings Ct.', 'Houston', 'TX', 77092, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if


numa=0
SQLString="INSERT INTO doctor "
SQLString=SQLString + "(Doc_Name_F, Doc_Name_L, Doc_Specialization, Doc_Gender, Doc_Email, Doc_Phone, Doc_DOB, Doc_Addr_Street, Doc_Addr_City, Doc_Addr_State, Doc_Addr_Zip, Doc_Deleted)"
SQLString=SQLString + " VALUES ('Vanessa', 'Durner', 'Pediatrician', 'F', 'v.durner@starcare.com', '5431281576', cast(cast(1976*10000 + 06*100 + 12 as varchar(255)) as date), '701 New Haven Rd.', 'Houston', 'TX', 77009, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO doctor "
SQLString=SQLString + "(Doc_Name_F, Doc_Name_L, Doc_Specialization, Doc_Gender, Doc_Email, Doc_Phone, Doc_DOB, Doc_Addr_Street, Doc_Addr_City, Doc_Addr_State, Doc_Addr_Zip, Doc_Deleted)"
SQLString=SQLString + " VALUES ('Herbert', 'Higginbotham', 'Psychologist', 'M', 'h.higginbotham@starcare.com', '5431283579', cast(cast(1970*10000 + 01*100 + 18 as varchar(255)) as date), '20 Cosmos Blvd.', 'Houston', 'TX', 77007, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO doctor "
SQLString=SQLString + "(Doc_Name_F, Doc_Name_L, Doc_Specialization, Doc_Gender, Doc_Email, Doc_Phone, Doc_DOB, Doc_Addr_Street, Doc_Addr_City, Doc_Addr_State, Doc_Addr_Zip, Doc_Deleted)"
SQLString=SQLString + " VALUES ('Hannibal', 'Lecter', 'Psychiatrist', 'M', 'h.lecter@starcare.com', '7139491192', cast(cast(1960*10000 + 03*100 + 12 as varchar(255)) as date), '4412 Insane St.', 'Fulshear', 'TX', 77441, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO doctor "
SQLString=SQLString + "(Doc_Name_F, Doc_Name_L, Doc_Specialization, Doc_Gender, Doc_Email, Doc_Phone, Doc_DOB, Doc_Addr_Street, Doc_Addr_City, Doc_Addr_State, Doc_Addr_Zip, Doc_Deleted)"
SQLString=SQLString + " VALUES ('Larry', 'Garfield', 'Cardiologist', 'M', 'l.garfield@starcare.com', '9794485918', cast(cast(1966*10000 + 06*100 + 06 as varchar(255)) as date), '666 Satans Maw Rd.', 'Fulshear', 'TX', 77441, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

'Office Table------------------------------------------------------------------------------------------------

numa=0
SQLString="INSERT INTO office "
SQLString=SQLString + "(Off_Doc_Mon, Off_Doc_Tue, Off_Doc_Wed, Off_Doc_Thu, Off_Doc_Fri, Off_Doc_Sat, Off_Addr_Street, Off_Addr_City, Off_Addr_State, Off_Addr_Zip, Off_Deleted)"
SQLString=SQLString + " VALUES (3, 3, 3, 3, 3, 3, '1200 Strawberry Ln', 'Houston', 'TX', 77077, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO office "
SQLString=SQLString + "(Off_Doc_Mon, Off_Doc_Tue, Off_Doc_Wed, Off_Doc_Thu, Off_Doc_Fri, Off_Doc_Sat, Off_Addr_Street, Off_Addr_City, Off_Addr_State, Off_Addr_Zip, Off_Deleted)"
SQLString=SQLString + " VALUES (2, 1, 2, 1, 2, 1, '3003 Chocolate Dr', 'Cypress', 'TX', 77433, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO office "
SQLString=SQLString + "(Off_Doc_Mon, Off_Doc_Tue, Off_Doc_Wed, Off_Doc_Thu, Off_Doc_Fri, Off_Doc_Sat, Off_Addr_Street, Off_Addr_City, Off_Addr_State, Off_Addr_Zip, Off_Deleted)"
SQLString=SQLString + " VALUES (1, 2, 1, 2, 1, 2, '15200 Katy Freeway', 'Katy', 'TX', 77450, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO office "
SQLString=SQLString + "(Off_Doc_Mon, Off_Doc_Tue, Off_Doc_Wed, Off_Doc_Thu, Off_Doc_Fri, Off_Doc_Sat, Off_Addr_Street, Off_Addr_City, Off_Addr_State, Off_Addr_Zip, Off_Deleted)"
SQLString=SQLString + " VALUES (5, 4, 5, 4, 5, 4, '15591 Warthog Dr', 'Fulshear', 'TX', 77441, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO office "
SQLString=SQLString + "(Off_Doc_Mon, Off_Doc_Tue, Off_Doc_Wed, Off_Doc_Thu, Off_Doc_Fri, Off_Doc_Sat, Off_Addr_Street, Off_Addr_City, Off_Addr_State, Off_Addr_Zip, Off_Deleted)"
SQLString=SQLString + " VALUES (4, 5, 4, 5, 4, 5, '1337 Delaville Dr.', 'Brookshire', 'TX', 77423, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

'Office Admin Table------------------------------------------------------------------------------------------------

numa=0
SQLString="INSERT INTO office_admin "
SQLString=SQLString + "(OA_Role,OA_Off_ID,OA_Name_F,OA_Name_L,OA_Gender,OA_Email,OA_Phone,OA_DOB,OA_Addr_Street, OA_Addr_City, OA_Addr_State, OA_Addr_Zip)"
SQLString=SQLString + " VALUES ('Nurse', 1,'Joanna', 'Jones', 'F','joannajones@starcare.com', '0987654321',cast(cast(1972*10000 + 07*100 + 28 as varchar(255)) as date),'3100 Main St', 'Houston', 'TX', 77009)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO office_admin "
SQLString=SQLString + "(OA_Role,OA_Off_ID,OA_Name_F,OA_Name_L,OA_Gender,OA_Email,OA_Phone,OA_DOB,OA_Addr_Street, OA_Addr_City, OA_Addr_State, OA_Addr_Zip)"
SQLString=SQLString + " VALUES ('Nurse', 2,'Princess', 'Peach', 'F','princesspeach@starcare.com', '0864297531',cast(cast(1965*10000 + 08*100 + 28 as varchar(255)) as date),'1200 Mushroom Rd', 'Cypress', 'TX', 77433)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO office_admin "
SQLString=SQLString + "(OA_Role,OA_Off_ID,OA_Name_F,OA_Name_L,OA_Gender,OA_Email,OA_Phone,OA_DOB,OA_Addr_Street, OA_Addr_City, OA_Addr_State, OA_Addr_Zip)"
SQLString=SQLString + " VALUES ('Admin', 3,'Patrick', 'Y', 'M','p.yee@starcare.com', '7133136969',cast(cast(1901*10000 + 01*100 + 01 as varchar(255)) as date), '777 Lucky Sevens Rd.', 'Fulshear', 'TX', 77441)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

    numa=0
SQLString="INSERT INTO office_admin "
SQLString=SQLString + "(OA_Role,OA_Off_ID,OA_Name_F,OA_Name_L,OA_Gender,OA_Email,OA_Phone,OA_DOB,OA_Addr_Street, OA_Addr_City, OA_Addr_State, OA_Addr_Zip)"
SQLString=SQLString + " VALUES ('Nurse', 4,'Stacy', 'Merlow', 'F','s.merlow@starcare.com', '9791428934',cast(cast(1999*10000 + 11*100 + 20 as varchar(255)) as date), '4112 Terra St.', 'Houston', 'TX', 77009)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO office_admin "
SQLString=SQLString + "(OA_Role,OA_Off_ID,OA_Name_F,OA_Name_L,OA_Gender,OA_Email,OA_Phone,OA_DOB,OA_Addr_Street, OA_Addr_City, OA_Addr_State, OA_Addr_Zip)"
SQLString=SQLString + " VALUES ('Nurse', 5,'Jerry', 'Fitzler', 'M','j.fitzler@starcare.com', '2815598119',cast(cast(1991*10000 + 11*100 + 30 as varchar(255)) as date), '1911 Candleston Ln.', 'Katy', 'TX', 77449)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

'Appointment Table------------------------------------------------------------------------------------------------

numa=0
SQLString="INSERT INTO appointment "
SQLString=SQLString + "(Appt_Doc_ID, Appt_Pat_ID, Appt_Office_ID, Appt_Date, Appt_Deleted)"
SQLString=SQLString + " VALUES (3, 1, 1, cast(cast(2019*10000 + 04*100 + 28 as varchar(255)) as date), 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO appointment "
SQLString=SQLString + "(Appt_Doc_ID, Appt_Pat_ID, Appt_Office_ID, Appt_Date, Appt_Deleted)"
SQLString=SQLString + " VALUES (1, 2, 3, cast(cast(2019*10000 + 04*100 + 29 as varchar(255)) as date), 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO appointment "
SQLString=SQLString + "(Appt_Doc_ID, Appt_Pat_ID, Appt_Office_ID, Appt_Date, Appt_Deleted)"
SQLString=SQLString + " VALUES (2, 3, 2, cast(cast(2019*10000 + 04*100 + 29 as varchar(255)) as date), 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO appointment "
SQLString=SQLString + "(Appt_Doc_ID, Appt_Pat_ID, Appt_Office_ID, Appt_Date, Appt_Deleted)"
SQLString=SQLString + " VALUES (5, 3, 4, cast(cast(2019*10000 + 04*100 + 29 as varchar(255)) as date), 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO appointment "
SQLString=SQLString + "(Appt_Doc_ID, Appt_Pat_ID, Appt_Office_ID, Appt_Date, Appt_Deleted)"
SQLString=SQLString + " VALUES (4, 3, 5, cast(cast(2019*10000 + 04*100 + 29 as varchar(255)) as date), 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

'Approval Table------------------------------------------------------------------------------------------------

numa=0
SQLString="INSERT INTO approval "
SQLString=SQLString + "(App_Doc_ID, App_Pat_ID, App_Spec_ID, App_Deleted)"
SQLString=SQLString + " VALUES (1, 1, 1, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO approval "
SQLString=SQLString + "(App_Doc_ID, App_Pat_ID, App_Spec_ID, App_Deleted)"
SQLString=SQLString + " VALUES (2, 2, 1, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO approval "
SQLString=SQLString + "(App_Doc_ID, App_Pat_ID, App_Spec_ID, App_Deleted)"
SQLString=SQLString + " VALUES (3, 3, 1, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO approval "
SQLString=SQLString + "(App_Doc_ID, App_Pat_ID, App_Spec_ID, App_Deleted)"
SQLString=SQLString + " VALUES (4, 4, 1, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO approval "
SQLString=SQLString + "(App_Doc_ID, App_Pat_ID, App_Spec_ID, App_Deleted)"
SQLString=SQLString + " VALUES (5, 5, 1, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

'Diagnosis Table------------------------------------------------------------------------------------------------

numa=0
SQLString="INSERT INTO diagnosis "
SQLString=SQLString + "(Diag_Appt_ID, Diag_Desc, Diag_Deleted)"
SQLString=SQLString + " VALUES (1, 'Cold, coughing, slight fever', 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO diagnosis "
SQLString=SQLString + "(Diag_Appt_ID, Diag_Desc, Diag_Deleted)"
SQLString=SQLString + " VALUES (2, 'Bacterial infection', 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO diagnosis "
SQLString=SQLString + "(Diag_Appt_ID, Diag_Desc, Diag_Deleted)"
SQLString=SQLString + " VALUES (1, 'Flu', 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO diagnosis "
SQLString=SQLString + "(Diag_Appt_ID, Diag_Desc, Diag_Deleted)"
SQLString=SQLString + " VALUES (1, 'Gastroenteritis', 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO diagnosis "
SQLString=SQLString + "(Diag_Appt_ID, Diag_Desc, Diag_Deleted)"
SQLString=SQLString + " VALUES (1, 'Fecal incontinence', 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

'Prescription Table------------------------------------------------------------------------------------------------

numa=0
SQLString="INSERT INTO prescription "
SQLString=SQLString + "(Pre_Appt_ID, Pre_Name, Pre_Refills_Allowed, Pre_Refills_Filled,Pre_Deleted)"
SQLString=SQLString + " VALUES (1, 'Theraflu', 1, 0, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO prescription "
SQLString=SQLString + "(Pre_Appt_ID, Pre_Name, Pre_Refills_Allowed, Pre_Refills_Filled,Pre_Deleted)"
SQLString=SQLString + " VALUES (2, 'Metronidazole', 1, 0, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

    numa=0
SQLString="INSERT INTO prescription "
SQLString=SQLString + "(Pre_Appt_ID, Pre_Name, Pre_Refills_Allowed, Pre_Refills_Filled,Pre_Deleted)"
SQLString=SQLString + " VALUES (3, 'Tamiflu', 1, 0, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO prescription "
SQLString=SQLString + "(Pre_Appt_ID, Pre_Name, Pre_Refills_Allowed, Pre_Refills_Filled,Pre_Deleted)"
SQLString=SQLString + " VALUES (4, 'Loperamide ', 1, 0, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO prescription "
SQLString=SQLString + "(Pre_Appt_ID, Pre_Name, Pre_Refills_Allowed, Pre_Refills_Filled,Pre_Deleted)"
SQLString=SQLString + " VALUES (5, 'Bismuth Subsalicylate ', 1, 0, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

'Login Table------------------------------------------------------------------------------------------------

numa=0
SQLString="INSERT INTO login "
SQLString=SQLString + "(Log_User_Name, Log_Pass, Log_EID, Log_User_Type, Log_Deleted)"
SQLString=SQLString + " VALUES ('jsmith', 'smith101', 1, 'P', 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO login "
SQLString=SQLString + "(Log_User_Name, Log_Pass, Log_EID, Log_User_Type, Log_Deleted)"
SQLString=SQLString + " VALUES ('jsmith2', 'smith101', 2, 'P', 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO login "
SQLString=SQLString + "(Log_User_Name, Log_Pass, Log_EID, Log_User_Type, Log_Deleted)"
SQLString=SQLString + " VALUES ('scraft', 'craft101', 4, 'P', 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO login "
SQLString=SQLString + "(Log_User_Name, Log_Pass, Log_EID, Log_User_Type, Log_Deleted)"
SQLString=SQLString + " VALUES ('acraft', 'craft101', 3, 'P', 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO login "
SQLString=SQLString + "(Log_User_Name, Log_Pass, Log_EID, Log_User_Type, Log_Deleted)"
SQLString=SQLString + " VALUES ('hcraft', 'craft101', 5, 'P', 1)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO login "
SQLString=SQLString + "(Log_User_Name, Log_Pass, Log_EID, Log_User_Type, Log_Deleted)"
SQLString=SQLString + " VALUES ('mmario', 'mario101', 7, 'P', 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO login "
SQLString=SQLString + "(Log_User_Name, Log_Pass, Log_EID, Log_User_Type, Log_Deleted)"
SQLString=SQLString + " VALUES ('lmario', 'mario101', 6, 'P', 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO login "
SQLString=SQLString + "(Log_User_Name, Log_Pass, Log_EID, Log_User_Type, Log_Deleted)"
SQLString=SQLString + " VALUES ('wknighton', 'knighton101', 1, 'D', 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO login "
SQLString=SQLString + "(Log_User_Name, Log_Pass, Log_EID, Log_User_Type, Log_Deleted)"
SQLString=SQLString + " VALUES ('vdurner', 'durner101', 2, 'D', 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO login "
SQLString=SQLString + "(Log_User_Name, Log_Pass, Log_EID, Log_User_Type, Log_Deleted)"
SQLString=SQLString + " VALUES ('hhigginbotham', 'higginbotham101', 3, 'D', 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO login "
SQLString=SQLString + "(Log_User_Name, Log_Pass, Log_EID, Log_User_Type, Log_Deleted)"
SQLString=SQLString + " VALUES ('joajones', 'jones72joanna', 1, 'A', 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

    numa=0
SQLString="INSERT INTO login "
SQLString=SQLString + "(Log_User_Name, Log_Pass, Log_EID, Log_User_Type, Log_Deleted)"
SQLString=SQLString + " VALUES ('patrick', 'spongebob', 8, 'A', 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

'Blood Test Table------------------------------------------------------------------------------------------------

numa=0
SQLString="INSERT INTO blood_test "
'RBCin mil cells/mcL, WBC in cells/mcL, Platelet count in thousand platelets/mcL,Hgb in gm/dL, Hct in %, MCV in fl/red cell
SQLString=SQLString + "(BT_Appt_ID,BT_RBC,BT_WBC,BT_Platelet_Cnt,BT_Hgb,BT_Hct,BT_MCV, BT_Deleted)"
SQLString=SQLString + " VALUES (1, 5.0, 4600, 300, 15.2, 45, 87, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO blood_test "
'RBCin mil cells/mcL, WBC in cells/mcL, Platelet count in thousand platelets/mcL,Hgb in gm/dL, Hct in %, MCV in fl/red cell
SQLString=SQLString + "(BT_Appt_ID,BT_RBC,BT_WBC,BT_Platelet_Cnt,BT_Hgb,BT_Hct,BT_MCV, BT_Deleted)"
SQLString=SQLString + " VALUES (2, 5.1, 9900, 250, 14.2, 45, 90, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO blood_test "
'RBCin mil cells/mcL, WBC in cells/mcL, Platelet count in thousand platelets/mcL,Hgb in gm/dL, Hct in %, MCV in fl/red cell
SQLString=SQLString + "(BT_Appt_ID,BT_RBC,BT_WBC,BT_Platelet_Cnt,BT_Hgb,BT_Hct,BT_MCV, BT_Deleted)"
SQLString=SQLString + " VALUES (3, 5.2, 6700, 244, 15.1, 40, 81, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO blood_test "
'RBCin mil cells/mcL, WBC in cells/mcL, Platelet count in thousand platelets/mcL,Hgb in gm/dL, Hct in %, MCV in fl/red cell
SQLString=SQLString + "(BT_Appt_ID,BT_RBC,BT_WBC,BT_Platelet_Cnt,BT_Hgb,BT_Hct,BT_MCV, BT_Deleted)"
SQLString=SQLString + " VALUES (4, 4.8, 10399, 441, 14.5, 47, 95, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

numa=0
SQLString="INSERT INTO blood_test "
'RBCin mil cells/mcL, WBC in cells/mcL, Platelet count in thousand platelets/mcL,Hgb in gm/dL, Hct in %, MCV in fl/red cell
SQLString=SQLString + "(BT_Appt_ID,BT_RBC,BT_WBC,BT_Platelet_Cnt,BT_Hgb,BT_Hct,BT_MCV, BT_Deleted)"
SQLString=SQLString + " VALUES (5, 4.9, 7600, 399, 13.9, 45, 89, 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if


'Email Table------------------------------------------------------------------------------------------------

numa=0
SQLString="INSERT INTO email "
SQLString=SQLString + "(Email_Message,Email_Deleted)"
SQLString=SQLString + " VALUES ('Message has been sent', 0)"
response.write "<P>Ready for Insert with SQLString = " + cstr(SQLString)
cn.execute SQLString,numa
if numa=1 then
	response.write "<P>Inserted OK numa="+cstr(numa)
else
	response.write "<P>Insert Failed. Number of records inserted="+cstr(numa)
end if

'------------------------------------------------------------------------------------------------
cn.close
set cn=nothing
%>
</body>
</html>