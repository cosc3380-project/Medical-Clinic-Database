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
set cn=Server.CreateObject("ADODB.Connection")
cn.open "gl1517","gl1517","MSX44gdnE"

numa = 0
SQL = "CREATE TABLE APPOINTMENT("
SQL = SQL + "	Appt_ID int NOT NULL IDENTITY(1,1),"
SQL = SQL + "	Appt_Doc_ID int NOT NULL,"
SQL = SQL + "	Appt_Pat_ID int NOT NULL,"
SQL = SQL + "	Appt_Office_ID int NOT NULL,"
SQL = SQL + "	Appt_Date date NULL,"
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
SQL = SQL + "	Diag_Desc varbinary(50) NULL,"
SQL = SQL + "	Diag_Deleted bit NULL,"
SQL = SQL + " 	primary key (Diag_ID))"
cn.execute SQL,numa

numa = 0
SQL = ""
SQL = SQL + "CREATE TABLE DOCTOR("
SQL = SQL + "	Doc_ID int NOT NULL IDENTITY(1,1),"
SQL = SQL + "	Doc_Name_F varchar(10) NULL,"
SQL = SQL + "	Doc_Name_L varchar(10) NULL,"
SQL = SQL + "	Doc_Email varchar(20) NULL,"
SQL = SQL + "	Doc_DOB date NULL,"
SQL = SQL + "	Doc_Phone varchar(10) NULL,"
SQL = SQL + "	Doc_Gender char(1) NULL,"
SQL = SQL + "	Doc_Specialization varchar(40) NULL,"
SQL = SQL + "	Doc_Addr_Street varchar(30) NULL,"
SQL = SQL + "	Doc_Addr_2 varchar(30) NULL,"
SQL = SQL + "	Doc_Addr_City varchar(20) NULL,"
SQL = SQL + "	Doc_Addr_State char(2) NULL,"
SQL = SQL + "	Doc_Addr_Zip int NULL,"
SQL = SQL + "	Doc_Deleted bit NULL,"
SQL = SQL + " 	primary key (Doc_ID))"
cn.execute SQL,numa

numa = 0
SQL = ""
SQL = SQL + "CREATE TABLE LOGIN("
SQL = SQL + "	Log_User_Name varchar(20) NOT NULL,"
SQL = SQL + "	Log_Pass varchar(10) NOT NULL,"
SQL = SQL + "	Log_EID int NOT NULL,"
SQL = SQL + "	Log_User_Type char(1) NOT NULL,"
SQL = SQL + "	Log_Deleted bit NULL,"
SQL = SQL + " 	primary key (Log_User_Name))"
cn.execute SQL,numa

numa = 0
SQL = ""
SQL = SQL + "CREATE TABLE OFFICE("
SQL = SQL + "	Off_ID int NOT NULL IDENTITY(1,1),"
SQL = SQL + "	Off_Sched_Mon int NULL,"
SQL = SQL + "	Off_Sched_Tue int NULL,"
SQL = SQL + "	Off_Sched_Wed int NULL,"
SQL = SQL + "	Off_Sched_Thu int NULL,"
SQL = SQL + "	Off_Sched_Fri int NULL,"
SQL = SQL + "	Off_Sched_Sat int NULL,"
SQL = SQL + "	Off_Sched_Sun int NULL,"
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
SQL = SQL + "	OA_Name_F varchar(10) NOT NULL,"
SQL = SQL + "	OA_Name_L varchar(10) NOT NULL,"
SQL = SQL + "	OA_Gender char(1) NULL,"
SQL = SQL + "	OD_DOB date NULL,"
SQL = SQL + "	OA_Addr_Street varchar(30) NOT NULL,"
SQL = SQL + "	OA_Addr_2 varchar(20) NULL,"
SQL = SQL + "	OA_Addr_City varchar(10) NOT NULL,"
SQL = SQL + "	OA_Addr_State varchar(10) NOT NULL,"
SQL = SQL + "	OA_Addr_Zip int NOT NULL,"
SQL = SQL + "	OA_Deleted bit NULL,"
SQL = SQL + " 	primary key (OA_ID))"
cn.execute SQL,numa

numa = 0
SQL = ""
SQL = SQL + "CREATE TABLE PATIENT("
SQL = SQL + "	Pat_ID int NOT NULL IDENTITY(1,1),"
SQL = SQL + "	Pat_Name_F varchar(20) NULL,"
SQL = SQL + "	Pat_Name_L varchar(10) NULL,"
SQL = SQL + "	Pat_Height float NULL,"
SQL = SQL + "	Pat_Weight float NULL,"
SQL = SQL + "	Pat_Gender char(1) NULL,"
SQL = SQL + "	Pat_Email varchar(20) NULL,"
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
SQL = SQL + "	Pre_Name varchar(10) NULL,"
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
SQL = SQL + "ALTER TABLE DOCTOR  WITH CHECK ADD CHECK  ((Doc_Phone like '0-90-90-90-90-90-90-90-90-90-9'))"
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
</body>
</html>