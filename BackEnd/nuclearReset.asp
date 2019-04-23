<HTML>
<body  bgcolor="#808080" link="#ffffff" text="#ffffff" vlink="#ffffff">
<table style="width:100%">
	<tr>
		<td style="width:33%;text-align:left">
			<a href='http://auckland.bauer.uh.edu/students/gl1517/'>Home</a>
		</td>
		<td style="width:33%;text-align:center">
			GL Account Query
		</td>
		<td style="width:33%;text-align:right">
			
		</td>
	</tr>
</table><hr><br>
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
	
	<%
	set cn=Server.CreateObject("ADODB.Connection")
	cn.open "gl1517","gl1517","MSX44gdnE"

	numa = 0
	SQL = "CREATE TABLE APPOINTMENT("
	SQL = SQL + "	Appt_ID int NOT NULL IDENTITY(1,1),"
	SQL = SQL + "	Appt_Doc_ID int NOT NULL,"
	SQL = SQL + "	Appt_Pat_ID int NOT NULL,"
	SQL = SQL + "	Appt_Office_ID int NOT NULL,"
	SQL = SQL + "	Appt_Date datetime NULL,"
	SQL = SQL + "	Appt_Deleted bit NULL,"
	SQL = SQL + " 	primary key (Appt_ID))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "CREATE TABLE APPROVAL("
	SQL = SQL + "	App_ID int NOT NULL IDENTITY(1,1),"
	SQL = SQL + "	App_Doc_ID int NOT NULL,"
	SQL = SQL + "	App_Pat_ID int NOT NULL,"
	SQL = SQL + "	App_Spec_ID int NOT NULL,"
	SQL = SQL + "	App_Given bit NULL,"
	SQL = SQL + "	App_Deleted bit NULL,"
	SQL = SQL + " 	primary key (App_ID))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "CREATE TABLE BLOOD_TEST("
	SQL = SQL + "	BT_ID int NOT NULL IDENTITY(1,1),"
	SQL = SQL + "	BT_APPT_ID int NOT NULL,"
	SQL = SQL + "	BT_RBC float NULL,"
	SQL = SQL + "	BT_WBC float NULL,"
	SQL = SQL + "	BT_Platelet_Cnt float NULL,"
	SQL = SQL + "	BT_Hgb float NULL,"
	SQL = SQL + "	BT_Hct float NULL,"
	SQL = SQL + "	BT_MCV float NULL,"
	SQL = SQL + "	BT_Deleted bit NULL,"
	SQL = SQL + " 	primary key (BT_ID))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "CREATE TABLE DIAGNOSIS("
	SQL = SQL + "	Diag_ID int NOT NULL IDENTITY(1,1),"
	SQL = SQL + "	Diag_Appt_ID int NOT NULL,"
	SQL = SQL + "	Diag_Desc varchar(50) NULL,"
	SQL = SQL + "	Diag_Deleted bit NULL,"
	SQL = SQL + " 	primary key (Diag_ID))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "CREATE TABLE DOCTOR("
	SQL = SQL + "	Doc_ID int NOT NULL IDENTITY(1,1),"
	SQL = SQL + "	Doc_Name_F varchar(20) NULL,"
	SQL = SQL + "	Doc_Name_L varchar(20) NULL,"
	SQL = SQL + "	Doc_Email varchar(35) NULL,"
	SQL = SQL + "	Doc_DOB date NULL,"
	SQL = SQL + "	Doc_Phone varchar(10) NULL,"
	SQL = SQL + "	Doc_Gender char(1) NULL,"
	SQL = SQL + "	Doc_Specialization varchar(40) NULL,"
	SQL = SQL + "	Doc_Addr_Street varchar(30) NULL,"
	SQL = SQL + "	Doc_Addr_2 varchar(20) NULL,"
	SQL = SQL + "	Doc_Addr_City varchar(10) NULL,"
	SQL = SQL + "	Doc_Addr_State char(2) NULL,"
	SQL = SQL + "	Doc_Addr_Zip int NULL,"
	SQL = SQL + "	Doc_Deleted bit NULL,"
	SQL = SQL + " 	primary key (Doc_ID))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "CREATE TABLE EMAIL("
	SQL = SQL + "	Email_ID int NOT NULL IDENTITY(1,1),"
	SQL = SQL + "	Email_Message varchar(70) NULL,"
	SQL = SQL + "	Email_Deleted bit NULL,"
	SQL = SQL + " 	primary key (Email_ID))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "CREATE TABLE LOGIN("
	SQL = SQL + "	Log_User_Name varchar(20) NOT NULL,"
	SQL = SQL + "	Log_Pass varchar(25) NOT NULL,"
	SQL = SQL + "	Log_EID int NOT NULL,"
	SQL = SQL + "	Log_User_Type char(1) NOT NULL,"
	SQL = SQL + "	Log_Deleted bit NULL,"
	SQL = SQL + " 	primary key (Log_User_Name))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "CREATE TABLE OFFICE("
	SQL = SQL + "	Off_ID int NOT NULL IDENTITY(1,1),"
	SQL = SQL + "	Off_Doc_Mon int NULL,"
	SQL = SQL + "	Off_Doc_Tue int NULL,"
	SQL = SQL + "	Off_Doc_Wed int NULL,"
	SQL = SQL + "	Off_Doc_Thu int NULL,"
	SQL = SQL + "	Off_Doc_Fri int NULL,"
	SQL = SQL + "	Off_Doc_Sat int NULL,"
	SQL = SQL + "	Off_Doc_Sun int NULL,"
	SQL = SQL + "	Off_Addr_Street varchar(30) NOT NULL,"
	SQL = SQL + "	Off_Addr_2 varchar(20) NULL,"
	SQL = SQL + "	Off_Addr_City varchar(10) NOT NULL,"
	SQL = SQL + "	Off_Addr_State varchar(10) NOT NULL,"
	SQL = SQL + "	Off_Addr_Zip int NOT NULL,"
	SQL = SQL + "	Off_Deleted bit NULL,"
	SQL = SQL + " 	primary key (Off_ID))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "CREATE TABLE OFFICE_ADMIN("
	SQL = SQL + "	OA_ID int NOT NULL IDENTITY(1,1),"
	SQL = SQL + "	OA_Role varchar(10) NOT NULL,"
	SQL = SQL + "	OA_Off_ID int NULL,"
	SQL = SQL + "	OA_Name_F varchar(20) NOT NULL,"
	SQL = SQL + "	OA_Name_L varchar(20) NOT NULL,"
	SQL = SQL + "	OA_Gender char(1) NULL,"
	SQL = SQL + "	OA_Email varchar(35) NOT NULL,"
	SQL = SQL + "	OA_Phone varchar(10) NULL,"
	SQL = SQL + "	OA_DOB date NULL,"
	SQL = SQL + "	OA_Addr_Street varchar(30) NOT NULL,"
	SQL = SQL + "	OA_Addr_2 varchar(20) NULL,"
	SQL = SQL + "	OA_Addr_City varchar(10) NOT NULL,"
	SQL = SQL + "	OA_Addr_State varchar(2) NOT NULL,"
	SQL = SQL + "	OA_Addr_Zip int NOT NULL,"
	SQL = SQL + "	OA_Deleted bit NULL,"
	SQL = SQL + " 	primary key (OA_ID))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "CREATE TABLE PATIENT("
	SQL = SQL + "	Pat_ID int NOT NULL IDENTITY(1,1),"
	SQL = SQL + "	Pat_Name_F varchar(20) NULL,"
	SQL = SQL + "	Pat_Name_L varchar(20) NULL,"
	SQL = SQL + "	Pat_Height float NULL,"
	SQL = SQL + "	Pat_Weight float NULL,"
	SQL = SQL + "	Pat_Gender char(1) NULL,"
	SQL = SQL + "	Pat_Email varchar(35) NULL,"
	SQL = SQL + "	Pat_Phone varchar(10) NULL,"
	SQL = SQL + "	Pat_DOB date NULL,"
	SQL = SQL + "	Pat_Addr_Street varchar(30) NULL,"
	SQL = SQL + "	Pat_Addr_2 varchar(20) NULL,"
	SQL = SQL + "	Pat_Addr_City varchar(10) NULL,"
	SQL = SQL + "	Pat_Addr_State char(2) NULL,"
	SQL = SQL + "	Pat_Addr_Zip int NULL,"
	SQL = SQL + "	Pat_Created_By varchar(20) NOT NULL,"
	SQL = SQL + "	Pat_Updated_By varchar(20) NOT NULL,"
	SQL = SQL + "	Pat_Created_Date date NULL,"
	SQL = SQL + "	Pat_Updated_Date date NULL,"
	SQL = SQL + "	Pat_Deleted bit NULL,"
	SQL = SQL + " 	primary key (Pat_ID))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "CREATE TABLE PRESCRIPTION("
	SQL = SQL + "	Pre_ID int NOT NULL IDENTITY(1,1),"
	SQL = SQL + "	Pre_Appt_ID int NOT NULL,"
	SQL = SQL + "	Pre_Name varchar(30) NULL,"
	SQL = SQL + "	Pre_Refills_Allowed int NULL,"
	SQL = SQL + "	Pre_Refills_Filled int NULL,"
	SQL = SQL + "	Pre_Deleted bit NULL,"
	SQL = SQL + " 	primary key (Pre_ID))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE APPOINTMENT  WITH CHECK ADD  CONSTRAINT FK_APPOINTMENT_DOCTOR FOREIGN KEY(Appt_Doc_ID)"
	SQL = SQL + "REFERENCES DOCTOR (Doc_ID)"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE APPOINTMENT CHECK CONSTRAINT FK_APPOINTMENT_DOCTOR"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE APPOINTMENT  WITH CHECK ADD  CONSTRAINT FK_APPOINTMENT_OFFICE FOREIGN KEY(Appt_Office_ID)"
	SQL = SQL + "REFERENCES OFFICE (Off_ID)"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE APPOINTMENT CHECK CONSTRAINT FK_APPOINTMENT_OFFICE"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE APPOINTMENT  WITH CHECK ADD  CONSTRAINT FK_APPOINTMENT_PATIENT FOREIGN KEY(Appt_Pat_ID)"
	SQL = SQL + "REFERENCES PATIENT (Pat_ID)"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE APPOINTMENT CHECK CONSTRAINT FK_APPOINTMENT_PATIENT"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE APPROVAL  WITH CHECK ADD  CONSTRAINT FK_APPROVAL_DOCTOR FOREIGN KEY(App_Doc_ID)"
	SQL = SQL + "REFERENCES DOCTOR (Doc_ID)"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE APPROVAL CHECK CONSTRAINT FK_APPROVAL_DOCTOR"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE APPROVAL  WITH CHECK ADD  CONSTRAINT FK_APPROVAL_PATIENT FOREIGN KEY(App_Pat_ID)"
	SQL = SQL + "REFERENCES PATIENT (Pat_ID)"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE APPROVAL CHECK CONSTRAINT FK_APPROVAL_PATIENT"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE DIAGNOSIS  WITH CHECK ADD  CONSTRAINT FK_DIAGNOSIS_APPOINTMENT FOREIGN KEY(Diag_Appt_ID)"
	SQL = SQL + "REFERENCES APPOINTMENT (Appt_ID)"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE DIAGNOSIS CHECK CONSTRAINT FK_DIAGNOSIS_APPOINTMENT"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE PRESCRIPTION  WITH CHECK ADD  CONSTRAINT FK_PRESCRIPTION_APPOINTMENT FOREIGN KEY(Pre_Appt_ID)"
	SQL = SQL + "REFERENCES APPOINTMENT (Appt_ID)"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE PRESCRIPTION CHECK CONSTRAINT FK_PRESCRIPTION_APPOINTMENT"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE APPOINTMENT  WITH CHECK ADD CHECK  ((Appt_ID>(0)))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE APPROVAL  WITH CHECK ADD CHECK  ((App_ID>=(0)))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE BLOOD_TEST  WITH CHECK ADD CHECK  ((BT_Hct>(0)))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE BLOOD_TEST  WITH CHECK ADD CHECK  ((BT_Hgb>(0)))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE BLOOD_TEST  WITH CHECK ADD CHECK  ((BT_MCV>(0)))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE BLOOD_TEST  WITH CHECK ADD CHECK  ((BT_Platelet_Cnt>(0)))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE BLOOD_TEST  WITH CHECK ADD CHECK  ((BT_RBC>(0)))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE BLOOD_TEST  WITH CHECK ADD CHECK  ((BT_WBC>(0)))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE DIAGNOSIS  WITH CHECK ADD CHECK  ((Diag_ID>=(0)))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE DOCTOR  WITH CHECK ADD CHECK  ((Doc_Addr_State='WY' OR Doc_Addr_State='WV' OR Doc_Addr_State='WI' OR Doc_Addr_State='WA' OR Doc_Addr_State='VT' OR Doc_Addr_State='VA' OR Doc_Addr_State='UT' OR Doc_Addr_State='TX' OR Doc_Addr_State='TN' OR Doc_Addr_State='SD' OR Doc_Addr_State='SC' OR Doc_Addr_State='RI' OR Doc_Addr_State='PA' OR Doc_Addr_State='OR' OR Doc_Addr_State='OK' OR Doc_Addr_State='OH' OR Doc_Addr_State='NY' OR Doc_Addr_State='NV' OR Doc_Addr_State='NM' OR Doc_Addr_State='NJ' OR Doc_Addr_State='NH' OR Doc_Addr_State='NE' OR Doc_Addr_State='ND' OR Doc_Addr_State='NC' OR Doc_Addr_State='MT' OR Doc_Addr_State='MS' OR Doc_Addr_State='MO' OR Doc_Addr_State='MN' OR Doc_Addr_State='MI' OR Doc_Addr_State='ME' OR Doc_Addr_State='MD' OR Doc_Addr_State='MA' OR Doc_Addr_State='LA' OR Doc_Addr_State='KY' OR Doc_Addr_State='KS' OR Doc_Addr_State='IN' OR Doc_Addr_State='IL' OR Doc_Addr_State='ID' OR Doc_Addr_State='IA' OR Doc_Addr_State='HI' OR Doc_Addr_State='GA' OR Doc_Addr_State='FL' OR Doc_Addr_State='DE' OR Doc_Addr_State='CT' OR Doc_Addr_State='CO' OR Doc_Addr_State='CA' OR Doc_Addr_State='AZ' OR Doc_Addr_State='AR' OR Doc_Addr_State='AL' OR Doc_Addr_State='AK'))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE DOCTOR  WITH CHECK ADD CHECK  ((Doc_Addr_Zip>=(0) AND Doc_Addr_Zip<=(99999)))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE DOCTOR  WITH CHECK ADD CHECK  ((Doc_Email like '%@%'))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE DOCTOR  WITH CHECK ADD CHECK  ((Doc_Gender='F' OR Doc_Gender='M'))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE DOCTOR  WITH CHECK ADD CHECK  ((Doc_ID>(0)))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE LOGIN  WITH CHECK ADD  CONSTRAINT CK__LOGIN__Log_Pass__5FB337D6 CHECK  ((len(Log_Pass)>=(8)))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE LOGIN CHECK CONSTRAINT CK__LOGIN__Log_Pass__5FB337D6"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE LOGIN  WITH CHECK ADD  CONSTRAINT CK__LOGIN__Log_User___60A75C0F CHECK  (len(Log_User_Name)>=(5))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE LOGIN CHECK CONSTRAINT CK__LOGIN__Log_User___60A75C0F"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE LOGIN  WITH CHECK ADD  CONSTRAINT CK__LOGIN__Log_User___619B8048 CHECK  ((Log_User_Type='A' OR Log_User_Type='D' OR Log_User_Type='P'))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE LOGIN CHECK CONSTRAINT CK__LOGIN__Log_User___619B8048"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE OFFICE  WITH CHECK ADD  CONSTRAINT CK_OFFICE_ZIP CHECK  ((off_addr_zip>=(0) AND off_addr_zip<=(99999) AND len(off_addr_zip)=(5)))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE OFFICE CHECK CONSTRAINT CK_OFFICE_ZIP"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE OFFICE_ADMIN  WITH CHECK ADD  CONSTRAINT CK_OFFICE_ADMIN CHECK  ((oa_addr_zip>=(0) AND oa_addr_zip<=(99999) AND len(oa_addr_zip)=(5)))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE OFFICE_ADMIN CHECK CONSTRAINT CK_OFFICE_ADMIN"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE PATIENT  WITH CHECK ADD CHECK  ((Pat_Addr_State='WY' OR Pat_Addr_State='WV' OR Pat_Addr_State='WI' OR Pat_Addr_State='WA' OR Pat_Addr_State='VT' OR Pat_Addr_State='VA' OR Pat_Addr_State='UT' OR Pat_Addr_State='TX' OR Pat_Addr_State='TN' OR Pat_Addr_State='SD' OR Pat_Addr_State='SC' OR Pat_Addr_State='RI' OR Pat_Addr_State='PA' OR Pat_Addr_State='OR' OR Pat_Addr_State='OK' OR Pat_Addr_State='OH' OR Pat_Addr_State='NY' OR Pat_Addr_State='NV' OR Pat_Addr_State='NM' OR Pat_Addr_State='NJ' OR Pat_Addr_State='NH' OR Pat_Addr_State='NE' OR Pat_Addr_State='ND' OR Pat_Addr_State='NC' OR Pat_Addr_State='MT' OR Pat_Addr_State='MS' OR Pat_Addr_State='MO' OR Pat_Addr_State='MN' OR Pat_Addr_State='MI' OR Pat_Addr_State='ME' OR Pat_Addr_State='MD' OR Pat_Addr_State='MA' OR Pat_Addr_State='LA' OR Pat_Addr_State='KY' OR Pat_Addr_State='KS' OR Pat_Addr_State='IN' OR Pat_Addr_State='IL' OR Pat_Addr_State='ID' OR Pat_Addr_State='IA' OR Pat_Addr_State='HI' OR Pat_Addr_State='GA' OR Pat_Addr_State='FL' OR Pat_Addr_State='DE' OR Pat_Addr_State='CT' OR Pat_Addr_State='CO' OR Pat_Addr_State='CA' OR Pat_Addr_State='AZ' OR Pat_Addr_State='AR' OR Pat_Addr_State='AL' OR Pat_Addr_State='AK'))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE PATIENT  WITH CHECK ADD CHECK  ((Pat_Addr_Zip>=(0) AND Pat_Addr_Zip<=(99999)))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE PATIENT  WITH CHECK ADD CHECK  ((Pat_Email like '%@%'))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE PATIENT  WITH CHECK ADD CHECK  ((Pat_Gender='F' OR Pat_Gender='M'))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE PATIENT  WITH CHECK ADD CHECK  ((Pat_Height>(0)))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE PATIENT  WITH CHECK ADD CHECK  ((Pat_ID>(0)))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE PATIENT  WITH CHECK ADD CHECK  ((Pat_Phone like '__________'))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE PATIENT  WITH CHECK ADD CHECK  ((Pat_Weight>(0)))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE PRESCRIPTION  WITH CHECK ADD CHECK  ((Pre_ID>(0)))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE PRESCRIPTION  WITH CHECK ADD CHECK  ((Pre_Refills_Allowed>=(0)))"
	cn.execute SQL,numa

	numa = 0
	SQL = ""
	SQL = SQL + "ALTER TABLE PRESCRIPTION  WITH CHECK ADD CHECK  ((Pre_Refills_Filled>=(0)))"
	cn.execute SQL,numa

	cn.close
	set cn=nothing
	%>

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