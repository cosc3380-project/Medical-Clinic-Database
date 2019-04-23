void validate(Object sender, EventArgs e)
{

	if(Page.IsValid)
	{
		string strSelectA;
		string strSelectB;
		string strConnect;

		strSelectA ="SELECT Pat_Email FROM patient WHERE Pat_Email = @email";
		strSelectB ="SELECT Log_User_Name FROM login WHERE Log_User_Name = @uName";
		strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";

		SqlConnection myConnection = new SqlConnection(strConnect);
		myConnection.Open();

		SqlCommand myCommandA = new SqlCommand(strSelectA, myConnection);
		SqlCommand myCommandB = new SqlCommand(strSelectB, myConnection);

		myCommandA.Parameters.AddWithValue( "@email", email.Text );
		myCommandB.Parameters.AddWithValue( "@uName", uidNew.Text );


		SqlDataReader objDataReader;

		//Check if email address already exists
		objDataReader = myCommandA.ExecuteReader();
		if(objDataReader.Read())
		{
			resultOut.InnerHtml = "Email Address already exists. Try using a different email address.";
			objDataReader.Close();
			myConnection.Close();
			return;
		}
		objDataReader.Close();

		//Check if username address already exists
		objDataReader = myCommandB.ExecuteReader();
		if(objDataReader.Read())
		{
			resultOut.InnerHtml = "User ID already exists. Try using a different login ID.";
			objDataReader.Close();
			myConnection.Close();
			return;
		}

		//If everything checks out, submit & add records to tables
		addToPatientTable();
		addToLoginTable();

		//Close connection and data reader object
		objDataReader.Close();
		myConnection.Close();
	}
	else
	{
		resultOut.InnerHtml = "";
	}
}
void addToPatientTable()
{
	int numa;
	string strInsert;
	string strConnect;
	string pNo;

	pNo = pNo1.Text + pNo2.Text + pNo3.Text;

	strInsert ="INSERT into patient (Pat_Name_F,Pat_Name_L,Pat_Gender,Pat_Email,Pat_Phone,Pat_Addr_Street,Pat_Addr_2,Pat_Addr_City,Pat_Addr_State,Pat_Addr_Zip,Pat_Created_By,Pat_Updated_By) VALUES (@fName,@lName,@gender,@email,@phone,@street,@street2,@city,@state,@zip,'Self','None')";
	strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";
	SqlConnection myConnection = new SqlConnection(strConnect);
	SqlCommand myCommand = new SqlCommand(strInsert, myConnection);

	myCommand.Parameters.AddWithValue( "@fName", fName.Text );
	myCommand.Parameters.AddWithValue( "@lName", lName.Text );
	myCommand.Parameters.AddWithValue( "@gender", gender.Text );
	myCommand.Parameters.AddWithValue( "@email", email.Text );
	myCommand.Parameters.AddWithValue( "@phone", pNo );
	myCommand.Parameters.AddWithValue( "@street", street.Text );
	myCommand.Parameters.AddWithValue( "@street2", street2.Text );
	myCommand.Parameters.AddWithValue( "@city", city.Text );
	myCommand.Parameters.AddWithValue( "@state", state.SelectedValue );
	myCommand.Parameters.AddWithValue( "@zip", zip.Text );
	myConnection.Open();
	numa = myCommand.ExecuteNonQuery();
	myConnection.Close();
}
void addToLoginTable()
{
	int numa;
	string strSelect;
	string strInsert;
	string strConnect;
	string uid = "0";

	//Create & open connection
	strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";
	SqlConnection myConnection = new SqlConnection(strConnect);
	myConnection.Open();

	//Get the ID of the current Patient
	strSelect ="SELECT Pat_ID FROM patient WHERE Pat_Email = @email";
	SqlCommand myCommandA = new SqlCommand(strSelect, myConnection);
	myCommandA.Parameters.AddWithValue( "@email", email.Text );
	SqlDataReader objDataReader;
	objDataReader = myCommandA.ExecuteReader();
	if(objDataReader.Read())
		uid = "" + objDataReader["Pat_ID"];
	objDataReader.Close();

	//Insert patient login data into login table
	strInsert ="INSERT into login (Log_User_Name,Log_Pass,Log_EID,Log_User_Type) VALUES (@uName,@uPass,@patID,'P')";
	SqlCommand myCommandB = new SqlCommand(strInsert, myConnection);
	myCommandB.Parameters.AddWithValue( "@uName", uidNew.Text );
	myCommandB.Parameters.AddWithValue( "@uPass", pwd.Text );
	myCommandB.Parameters.AddWithValue( "@patID", uid);
	numa = myCommandB.ExecuteNonQuery();
	resultOut.InnerHtml = numa.ToString();
	myConnection.Close();
}