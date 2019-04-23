<%@Page Language="C#"%>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="System.Data.SqlClient" %>
<%@Import Namespace="System.Text.RegularExpressions" %>
<HTML>
    <head>
        <!-- Title Page-->
        <title>Create Account</title>

        <!-- Icons font CSS-->
        <link href="vendor/mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
        <link href="vendor/font-awesome-4.7/css/font-awesome.min.css" rel="stylesheet" media="all">
        <!-- Font special for pages-->
        <link href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

        <!-- Vendor CSS-->
        <link href="vendor/select2/select2.min.css" rel="stylesheet" media="all">
        <link href="vendor/datepicker/daterangepicker.css" rel="stylesheet" media="all">

        <!-- Main CSS-->
        <link href="css/main-signup.css" rel="stylesheet" media="all">
    </head>
	<script language="C#" runat="server"> 
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
            DateTime dob;


            pNo = pNo1.Text + pNo2.Text + pNo3.Text;
            dob = new DateTime( Convert.ToInt32(dobYear.Text), Convert.ToInt32(dobMonth.Text), Convert.ToInt32(dobDay.Text));

            strInsert ="INSERT into patient (Pat_Name_F,Pat_Name_L,Pat_Gender,Pat_Email,Pat_Phone,Pat_DOB,Pat_Addr_Street,Pat_Addr_2,Pat_Addr_City,Pat_Addr_State,Pat_Addr_Zip,Pat_Created_By,Pat_Created_Date,Pat_Updated_By) VALUES (@fName,@lName,@gender,@email,@phone,@dob,@street,@street2,@city,@state,@zip,'Self',@dateCreated,'None')";
            strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";
            SqlConnection myConnection = new SqlConnection(strConnect);
            SqlCommand myCommand = new SqlCommand(strInsert, myConnection);

            myCommand.Parameters.AddWithValue( "@fName", fName.Text );
            myCommand.Parameters.AddWithValue( "@lName", lName.Text );
            myCommand.Parameters.AddWithValue( "@gender", gender.Text );
            myCommand.Parameters.AddWithValue( "@email", email.Text );
            myCommand.Parameters.AddWithValue( "@dob", SqlDbType.Date).Value = dob;
            myCommand.Parameters.AddWithValue( "@phone", pNo );
            myCommand.Parameters.AddWithValue( "@street", street.Text );
            myCommand.Parameters.AddWithValue( "@street2", street2.Text );
            myCommand.Parameters.AddWithValue( "@city", city.Text );
            myCommand.Parameters.AddWithValue( "@state", state.SelectedValue );
            myCommand.Parameters.AddWithValue( "@zip", zip.Text );
            myCommand.Parameters.AddWithValue( "@dateCreated", SqlDbType.Date).Value = DateTime.Now;
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

        protected void gender_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
</SCRIPT>

	<BODY>
        
		<div class="page-wrapper bg-gra-02 p-t-130 p-b-100 font-poppins">
        <center>
		<form id="form1" runat="server">
        <div class="card card-4" style="width:50%">
            <div class="card-body">
		<h2 class="title">Create Account</h2><hr><br />
        <table style="font-size:14px;border-spacing:20px;border-collapse: separate;">
				
		<tr>
		    <td style="text-align:center" colspan=2>
                <label class="label">Personal Information</label>
		    </td>
		</tr>
				
		<tr>
            <td style="width:50%">
                <label class="label">First Name </label>
                <asp:TextBox ID="fName" runat="server" maxlength="20" style="width:100%" name="fName" class="input--style-4" />
		    </td>
		
            <td>
                <label class="label">Last Name: </label>
                <asp:TextBox ID="lName" runat="server" maxlength="10" style="width:100%" name="lName" class="input--style-4" />
            </td>
		</tr>
		
        <tr>
		    <td>
                <label class="label">Phone Number: </label>
		        <div style="text-align:center;vertical-align:super">
                    <asp:TextBox ID="pNo1" runat="server" name="pNo1" maxlength="3" style="width:30%" class="input--style-4" />&nbsp-
                    <asp:TextBox ID="pNo2" runat="server" name="pNo2" maxlength="3" style="width:30%" class="input--style-4" />&nbsp-
                    <asp:TextBox ID="pNo3" runat="server" name="pNo3" maxlength="4" style="width:30%" class="input--style-4" />
		        </div>
            </td>
        
            <td>
                <label class="label">Email Address: </label>
                <asp:TextBox ID="email" runat="server" maxlength="20" style="width:100%" name="email" class="input--style-4" />
		    </td>
		</tr>
				
		<tr>
		    <td>
                <label class="label">Gender: </label>
                <asp:DropDownList ID="gender" runat="server" style="Width:100%" class="input--style-4">
                    <asp:ListItem Text="M" value="M" />
                    <asp:ListItem Text="F" value="F" />
                </asp:DropDownList>
            </td>
		
		    <td>
                <label class="label">Date of Birth: </label>
                <div style="text-align:center;vertical-align:super">
                    <asp:TextBox ID="dobMonth" runat="server" name="dobMonth" maxlength="2" style="width:30%" class="input--style-4" />&nbsp/
                    <asp:TextBox ID="dobDay" runat="server" name="dobDay" maxlength="2" style="width:30%" class="input--style-4" />&nbsp/
                    <asp:TextBox ID="dobYear" runat="server" name="dobYear" maxlength="4" style="width:30%" class="input--style-4" />
		        </div>
		    </td>
		</tr>
				
		<tr>
		    <td style="text-align:center" colspan=2>
                <hr><br /><label class="label">Address</label>
		    </td>
		</tr>
				
		<tr>
		    <td>
                <label class="label">Street</label>
                <asp:TextBox ID="street" runat="server" maxlength="30" style="width:100%" name="street" class="input--style-4" />
		    </td>
		
		    <td>
                <label class="label">Apt #, Suite #, etc.</label>
                <asp:TextBox ID="street2" runat="server" maxlength="20" style="width:100%" name="street2" class="input--style-4" />
		    </td>
		</tr>
				
		<tr>
		    <td>
                <label class="label">City</label>
                <asp:TextBox ID="city" runat="server" maxlength="10" style="width:100%" name="city" class="input--style-4" />
		    </td>
		
		    <td>
                <label class="label">State</label>
                <asp:DropDownList ID="state" runat="server" style="width:100%" class="input--style-4" >
                    <asp:ListItem></asp:ListItem>
                    <asp:ListItem>AL</asp:ListItem>
			        <asp:ListItem>AK</asp:ListItem>
			        <asp:ListItem>AZ</asp:ListItem>
			        <asp:ListItem>AR</asp:ListItem>
			        <asp:ListItem>CA</asp:ListItem>
			        <asp:ListItem>CO</asp:ListItem>
			        <asp:ListItem>CT</asp:ListItem>
			        <asp:ListItem>DE</asp:ListItem>
			        <asp:ListItem>FL</asp:ListItem>
			        <asp:ListItem>GA</asp:ListItem>
			        <asp:ListItem>HI</asp:ListItem>
			        <asp:ListItem>ID</asp:ListItem>
			        <asp:ListItem>IL</asp:ListItem>
			        <asp:ListItem>IN</asp:ListItem>
			        <asp:ListItem>IA</asp:ListItem>
			        <asp:ListItem>KS</asp:ListItem>
			        <asp:ListItem>KY</asp:ListItem>
			        <asp:ListItem>LA</asp:ListItem>
			        <asp:ListItem>ME</asp:ListItem>
			        <asp:ListItem>MD</asp:ListItem>
			        <asp:ListItem>MA</asp:ListItem>
			        <asp:ListItem>MI</asp:ListItem>
			        <asp:ListItem>MN</asp:ListItem>
			        <asp:ListItem>MS</asp:ListItem>
			        <asp:ListItem>MO</asp:ListItem>
			        <asp:ListItem>MT</asp:ListItem>
			        <asp:ListItem>NE</asp:ListItem>
			        <asp:ListItem>NV</asp:ListItem>
			        <asp:ListItem>NH</asp:ListItem>
			        <asp:ListItem>NJ</asp:ListItem>
			        <asp:ListItem>NM</asp:ListItem>
			        <asp:ListItem>NY</asp:ListItem>
			        <asp:ListItem>NC</asp:ListItem>
			        <asp:ListItem>ND</asp:ListItem>
			        <asp:ListItem>OH</asp:ListItem>
			        <asp:ListItem>OK</asp:ListItem>
			        <asp:ListItem>OR</asp:ListItem>
			        <asp:ListItem>PA</asp:ListItem>
			        <asp:ListItem>RI</asp:ListItem>
			        <asp:ListItem>SC</asp:ListItem>
			        <asp:ListItem>SD</asp:ListItem>
			        <asp:ListItem>TN</asp:ListItem>
			        <asp:ListItem>TX</asp:ListItem>
			        <asp:ListItem>UT</asp:ListItem>
			        <asp:ListItem>VT</asp:ListItem>
			        <asp:ListItem>VA</asp:ListItem>
			        <asp:ListItem>WA</asp:ListItem>
			        <asp:ListItem>WV</asp:ListItem>
			        <asp:ListItem>WI</asp:ListItem>
			        <asp:ListItem>WY</asp:ListItem>
                </asp:DropDownList>
		    </td>
		</tr>
				
		<tr>
		    <td>
                <label class="label">Zip Code</label>
                <asp:TextBox ID="zip" runat="server"  maxlength="5" style="width:100%" name="zip" class="input--style-4" />
		    </td>
		</tr>
		
        <tr>
		    <td style="text-align:center" colspan=2>
                <hr><br /><label class="label">Login Details</label>
		    </td>
		</tr>
				
		<tr>
		    <td style="text-align:center">
                <label class="label">Create a Username: </label>
		    </td>

		    <td style="text-align:center">
                <asp:TextBox runat="server" maxlength="20" style="width:100%" name="uidNew" id="uidNew" class="input--style-4" />
		    </td>
		</tr>
				
		<tr>
		    <td style="text-align:center">
                <label class="label">Create a Password:</label>
		    </td>
		    
            <td style="text-align:center">
                <asp:TextBox ID="pwd" runat="server" name="pwd" maxlength="15" style="width:100%" TextMode="Password" class="input--style-4" />
            </td>
		</tr>
				
		<tr>
		    <td style="text-align:center">
                <label class="label">Confirm Password:</label>
		    </td>

		    <td style="text-align:center">
                <asp:TextBox runat="server" name="pwd_confirm" maxlength="15" style="width:100%" id="pwd_confirm" TextMode="Password" class="input--style-4" />
		    </td>
		</tr>
				
		</table>
                <!--Make text red-->
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" HeaderText="Please check and correct these fields:" DisplayMode="List" />
              </div>
        </div>
            <br />
            <br>
		    <asp:Button ID="returnBtn" runat="server" Text="Return to Login" UseSubmitBehavior="False" class="btn btn--radius-2 btn--blue" style="width:20%" CausesValidation="False" PostBackUrl="http://auckland.bauer.uh.edu/students/gl1517/cosc3380/login.aspx"></asp:Button>
            &nbsp
            <asp:Button ID="submitBtn" runat="server" Text="Create Account" OnClick="validate" UseSubmitBehavior="False" class="btn btn--radius-2 btn--green" style="width:20%"></asp:Button>
            <br />
            <br />
			<asp:RegularExpressionValidator ID="pNoValidator1" runat="server" ErrorMessage="Phone Number - Area Code must be 3 digits only" ControlToValidate="pNo1" ValidationExpression="\d{3}" Display="None" ></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator ID="pNoValidator2" runat="server" ErrorMessage="Phone Number - Middle 3 must be 3 digits only" ControlToValidate="pNo2" ValidationExpression="\d{3}" Display="None"></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator ID="pNoValidator3" runat="server" ErrorMessage="Phone Number - Last 4 must be 4 digits only" ControlToValidate="pNo3" ValidationExpression="\d{4}" Display="None"></asp:RegularExpressionValidator>
            <asp:RangeValidator ID="dobValidator1" runat="server" ErrorMessage="Date of Birth - Please enter a valid Month" MaximumValue="12" MinimumValue="1" ControlToValidate="dobMonth" Display="None"></asp:RangeValidator>
            <asp:RangeValidator ID="dobValidator2" runat="server" ErrorMessage="Date of Birth - Please enter a valid Day" MaximumValue="31" MinimumValue="1" ControlToValidate="dobDay" Display="None"></asp:RangeValidator>
            <asp:RangeValidator ID="dobValidator3" runat="server" ErrorMessage="Date of Birth - Please enter a valid Year" MaximumValue="2019" MinimumValue="1900" ControlToValidate="dobYear" Display="None"></asp:RangeValidator>
            <asp:RegularExpressionValidator ID="emailValidator" runat="server" ErrorMessage="Email Address isn't complete" ControlToValidate="email" Display="None" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator ID="zipValidator" runat="server" ErrorMessage="Zip Code must be 5 digits only" ValidationExpression="\d{5}" Display="None" ControlToValidate="zip"></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator ID="passValidator" runat="server" ErrorMessage="Password must be at least 8 characters long" ValidationExpression="\w{8,15}" Display="None" ControlToValidate="pwd"></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator ID="uidValidator" runat="server" ErrorMessage="User Name must be at least 5 characters long" ValidationExpression="\w{5,20}" Display="None" ControlToValidate="uidNew"></asp:RegularExpressionValidator>
            <asp:CompareValidator ID="pwdValidator" runat="server" ErrorMessage="Passwords do not match" ControlToCompare="pwd" ControlToValidate="pwd_confirm" Display="None"></asp:CompareValidator>
            <br />
            <asp:RequiredFieldValidator ID="fNameRequiredValidator" runat="server" ErrorMessage="First Name is required" ControlToValidate="fName" Display="None"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="lNameRequiredValidator" runat="server" ErrorMessage="Last Name is required" ControlToValidate="lName" Display="None"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="emailRequiredValidator" runat="server" ErrorMessage="Email Address is required" ControlToValidate="email" Display="None"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="pNo1RequiredValidator" runat="server" ErrorMessage="Phone Area Code is required" ControlToValidate="pNo1" Display="None"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="pNo2RequiredValidator" runat="server" ErrorMessage="Phone middle 3 digits are required" ControlToValidate="pNo2" Display="None"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="pNo3RequiredValidator" runat="server" ErrorMessage="Phone last 4 digits are required" ControlToValidate="pNo3" Display="None"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="dobDayRequiredValidator" runat="server" ErrorMessage="Day of Birth is required" ControlToValidate="dobMonth" Display="None"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="dobMonthRequiredValidator" runat="server" ErrorMessage="Month of Birth is required" ControlToValidate="dobDay" Display="None"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="dobYearRequiredValidator" runat="server" ErrorMessage="Year of Birth is required" ControlToValidate="dobYear" Display="None"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="streetRequiredValidator" runat="server" ErrorMessage="Street is required" ControlToValidate="street" Display="None"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="cityRequiredValidator" runat="server" ErrorMessage="City is required" ControlToValidate="city" Display="None"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="stateRequiredValidator" runat="server" ErrorMessage="State is required" ControlToValidate="state" Display="None"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="zipRequiredValidator" runat="server" ErrorMessage="Zip Code is required" ControlToValidate="zip" Display="None"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="uidRequiredValidator" runat="server" ErrorMessage="Username is required" ControlToValidate="uidNew" Display="None"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="pwdRequiredValidator" runat="server" ErrorMessage="Password is required" ControlToValidate="pwd" Display="None"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="pwdConfirmRequiredValidator" runat="server" ErrorMessage="Confirm Password is required" ControlToValidate="pwd_confirm" Display="None"></asp:RequiredFieldValidator> 
		</form>
        <br /><br /><br /><div id="resultOut" runat="server"></div>
        </div>
    </BODY>
</HTML>