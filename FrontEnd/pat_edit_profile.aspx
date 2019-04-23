<%@Page Language="C#" Debug="true" %>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="System.Data.SqlClient" %>
<%@Import Namespace="System.Text.RegularExpressions" %>
<html lang="en">
<!-- BEGIN HEAD -->
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <meta name="description" content="Responsive Admin Template" />
    <meta name="author" content="Sunray" />
    <title>StarCare Patient Portal</title>
    <!-- google font -->
    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet" type="text/css" />
    <!-- icons -->
    <link href="fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <!--bootstrap -->
    <link href="plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- full calendar -->
    <link href="plugins/fullcalendar/fullcalendar.css" rel="stylesheet" type="text/css" />
    <!-- Material Design Lite CSS -->
    <link href="plugins/material/material.min.css" rel="stylesheet">
    <link href="css/material_style.css" rel="stylesheet">
    <!-- Theme Styles -->
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="css/plugins.min.css" rel="stylesheet" type="text/css" />
    <link href="css/responsive.css" rel="stylesheet" type="text/css" />
    <link href="css/theme-color.css" rel="stylesheet" type="text/css" />
    <!-- favicon -->
    <link rel="shortcut icon" href="img/favicon.ico" />
</head>
 <!-- END HEAD -->
<script language="C#" runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.LoadComplete += new EventHandler(Page_LoadComplete);
    }
    protected void Page_LoadComplete(object sender, EventArgs e)
    {
        setupPage();
    }
    void setupPage()
    {
        string User_EID = "-1";

        //Get user cookie data
        HttpCookie uInfo = Request.Cookies["uInfo"];
        if(uInfo != null)
        {
            //If successful, set up page data
            loadUserData(uInfo); //TODO: Ensure this loads on initial page load

        }
        else
        {
            //Silently note that an error occured
            namePlate.InnerHtml = "<p>" + User_EID + "</p><small>Doctor</small>";
        }
    }
    void loadUserData(HttpCookie uInfo)
    {
        //Loads components specific to the current user
        string strSelect;
        string strConnect;

        strSelect ="SELECT * FROM patient WHERE Pat_ID = @EID";
        strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";

        SqlConnection myConnection = new SqlConnection(strConnect);
        myConnection.Open();
        SqlCommand myCommand = new SqlCommand(strSelect, myConnection);
        myCommand.Parameters.AddWithValue( "@EID", uInfo["EID"].ToString());

        SqlDataReader objDataReader;
        objDataReader = myCommand.ExecuteReader();
        if (objDataReader.Read())
        {
            string fName = objDataReader["Pat_Name_F"].ToString();
            string lName = objDataReader["Pat_Name_L"].ToString();

            string pNo = objDataReader["Pat_Phone"].ToString();

            //Set page placeholders
            namePlate.InnerHtml = "<p>" + fName + " " + lName + "</p>";
            email.Text = objDataReader["Pat_Email"].ToString();
            pNo1.Text = pNo.Substring(0, 3);
            pNo2.Text = pNo.Substring(3, 3);
            pNo3.Text = pNo.Substring(6, 4);
            street.Text = objDataReader["Pat_Addr_Street"].ToString();
            street2.Text = objDataReader["Pat_Addr_2"].ToString();
            city.Text = objDataReader["Pat_Addr_City"].ToString();
            state.SelectedValue = objDataReader["Pat_Addr_State"].ToString();
            zip.Text = objDataReader["Pat_Addr_Zip"].ToString();
        }
        objDataReader.Close();
        myConnection.Close();
    }
    void validate(Object sender, EventArgs e)
    {
        //Get user cookie data
        HttpCookie uInfo = Request.Cookies["uInfo"];
        if(uInfo != null)
        {
            //If successful, set up page data
            if (Page.IsValid)
            {
                string strSelectA;
                string strConnect;

                strSelectA ="SELECT Pat_Email FROM patient WHERE Pat_Email = @email AND Pat_ID <> @EID";
                strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";

                SqlConnection myConnection = new SqlConnection(strConnect);
                myConnection.Open();

                SqlCommand myCommandA = new SqlCommand(strSelectA, myConnection);

                myCommandA.Parameters.AddWithValue( "@email", email.Text );
                myCommandA.Parameters.AddWithValue( "@EID", uInfo["EID"].ToString() );


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

                //If everything checks out, update the data
                updatePatientTable(uInfo);

                //Close connection and data reader object
                objDataReader.Close();
                myConnection.Close();
            }
            else
            {
                resultOut.InnerHtml = "";
            }
        }
        else
        {
            //Silently note that an error occured
            namePlate.InnerHtml = "<p>-1</p><small>0</small>";
        }
    }
    void updatePatientTable(HttpCookie uInfo)
    {
        int numa;
        string strInsert;
        string strConnect;
        string pNo;

        pNo = pNo1.Text + pNo2.Text + pNo3.Text;

        strInsert ="UPDATE patient SET " +
                "Pat_Email = @email, " +
                "Pat_Phone = @phone, " +
                "Pat_Addr_Street = @street, " +
                "Pat_Addr_2 = @street2, " +
                "Pat_Addr_City = @city, " +
                "Pat_Addr_State = @state, " +
                "Pat_Addr_Zip = @zip, " +
                "Pat_Updated_By = 'Self', " +
                "Pat_Updated_Date = @dateUpdated " +
                "WHERE Pat_ID = @EID";
        strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";
        SqlConnection myConnection = new SqlConnection(strConnect);
        SqlCommand myCommand = new SqlCommand(strInsert, myConnection);

        myCommand.Parameters.AddWithValue( "@email", email.Text );
        myCommand.Parameters.AddWithValue( "@phone", pNo );
        myCommand.Parameters.AddWithValue( "@street", street.Text );
        myCommand.Parameters.AddWithValue( "@street2", street2.Text );
        myCommand.Parameters.AddWithValue( "@city", city.Text );
        myCommand.Parameters.AddWithValue( "@state", state.SelectedValue);
        myCommand.Parameters.AddWithValue( "@zip", zip.Text );
        myCommand.Parameters.AddWithValue( "@dateUpdated", SqlDbType.Date).Value = DateTime.Now;
        myCommand.Parameters.AddWithValue( "@EID", uInfo["EID"].ToString() );
        myConnection.Open();
        numa = myCommand.ExecuteNonQuery();
        myConnection.Close();
    }
</script>
<body class="page-header-fixed sidemenu-closed-hidelogo page-content-white page-md header-white dark-color logo-dark">
    <div class="page-wrapper">
        <!-- start header -->
        <div class="page-header navbar navbar-fixed-top">
            <div class="page-header-inner ">
                <!-- logo start -->
                <div class="page-logo">
                    <a href="pat_profile.aspx">
                        <span class="logo-default">StarCare</span>
                    </a>
                </div>
                <!-- logo end -->
                <ul class="nav navbar-nav navbar-left in">
                    <li><a href="#" class="menu-toggler sidebar-toggler font-size-20"><i class="fa fa-exchange" aria-hidden="true"></i></a></li>
                </ul>
                <ul class="nav navbar-nav navbar-left in">
                    <!-- start full screen button -->
                    <li><a href="javascript:;" class="fullscreen-click font-size-20"><i class="fa fa-arrows-alt"></i></a></li>
                    <!-- end full screen button -->
                </ul>
                <!-- start mobile menu -->
                <a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse">
                    <span></span>
                </a>
                <!-- end mobile menu -->
                <!-- start header menu -->
                <div class="top-menu">
                    <ul class="nav navbar-nav pull-right">
                        <!-- start manage user dropdown -->
                        <li class="dropdown dropdown-user">
                            <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                                <img alt="" class="img-circle " src="img/dp.jpg" />
                            </a>
                            <ul class="dropdown-menu dropdown-menu-default">
                                <li>
                                    <a href="login.aspx">
                                        <i class="fa fa-sign-out"></i> Log Out
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <!-- end manage user dropdown -->
                    </ul>
                </div>
            </div>
        </div>
        <!-- end header -->
               <!-- start page container -->
        <div class="page-container">
 			<!-- start sidebar menu -->
 			<div class="sidebar-container">
 				<div class="sidemenu-container navbar-collapse collapse fixed-menu">
	                <div id="remove-scroll" class="left-sidemenu">
	                    <ul class="sidemenu  page-header-fixed slimscroll-style" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200" style="padding-top: 20px">
	                        <li class="sidebar-toggler-wrapper hide">
	                            <div class="sidebar-toggler">
	                                <span></span>
	                            </div>
	                        </li>
	                        <li class="sidebar-user-panel">
	                            <div class="user-panel">
	                                <div class="pull-left info" id="namePlate" runat="server">
	                                    
	                                </div>
	                            </div>
	                        </li>
							<li class="nav-item  ">
	                            <a href="#" class="nav-link nav-toggle"> <i class="material-icons">person</i>
	                                <span class="title">My Profile</span> <span class="arrow"></span>
	                            </a>
	                            <ul class="sub-menu">
	                                <li class="nav-item  ">
	                                    <a href="pat_profile.aspx" class="nav-link "> <span class="title">Profile</span>
	                                    </a>	                                
	                                </li>
									 <li class="nav-item  ">
	                                    <a href="pat_edit_profile.aspx" class="nav-link "> <span class="title">Edit Profile</span>
	                                    </a>	                                
	                                </li>
	                            </ul>
	                        </li>
	                        <li class="nav-item  ">
	                            <a href="#" class="nav-link nav-toggle"><i class="material-icons">assignment</i>
	                            <span class="title">Appointment</span><span class="arrow"></span></a>
	                            <ul class="sub-menu">
	                                <li class="nav-item  ">
	                                    <a href="pat_select_doctor.aspx" class="nav-link "> <span class="title">Book Appointment</span>
	                                    </a>
	                                </li>
	                                <li class="nav-item  ">
	                                    <a href="pat_view_appointment.aspx" class="nav-link "> <span class="title">View All Appointment</span>
	                                    </a>
	                                </li>
	                            </ul>
	                        </li>
	                        <li class="nav-item  ">
	                            <a href="#" class="nav-link nav-toggle"> <i class="material-icons">person</i>
	                                <span class="title">Test Result</span> <span class="arrow"></span>
	                            </a>
	                            <ul class="sub-menu">
	                                <li class="nav-item  ">
	                                    <a href="pat_blood_test.aspx" class="nav-link "> <span class="title">Blood Test</span>
	                                    </a>	                                
	                                </li>
									 <li class="nav-item  ">
	                                    <a href="pat_diagnosis.aspx" class="nav-link "> <span class="title">Diagnosis</span>
	                                    </a>	                                
	                                </li>
	                            </ul>
	                        </li>
							<li class="nav-item  ">
	                            <a href="#" class="nav-link nav-toggle"> <i class="material-icons">person</i>
	                                <span class="title">Prescription</span> <span class="arrow"></span>
	                            </a>
	                            <ul class="sub-menu">
	                                <li class="nav-item  ">
	                                    <a href="pat_prescription.aspx" class="nav-link "> <span class="title">My Prescription</span>
	                                    </a>	                                
	                                </li>
	                            </ul>
	                        </li>
	                    </ul>
	                </div>
                </div>
            </div>
            <!-- end sidebar menu -->
            <!-- start page content -->
            <div class="page-content-wrapper">
                <div class="page-content">
                    <div class="page-bar">
                        <div class="page-title-breadcrumb">
                            <div class=" pull-left">
                                <div class="page-title">Edit Profile</div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="card card-box">
                                <div class="card-head">
                                    <header>Contact Information</header>
                                </div>
                                <div class="card-body" id="bar-parent">
                                    <form id="updateForm" class="form-horizontal" runat="server">
                                        <div class="form-body">
                                        Phone & Email
                                        <div class="form-group row">
                                                <label class="control-label col-md-3">Mobile No.
                                                    <span class="required"> * </span>
                                                </label>
                                                <div class="col-md-5">
                                                    <asp:TextBox id="pNo1" placeholder="Mobile Number" style="width:10%" maxlength="3" value="" runat="server" />&nbsp-&nbsp
                                                    <asp:TextBox id="pNo2" placeholder="Mobile Number" style="width:10%" maxlength="3" value="" runat="server" />&nbsp-&nbsp
                                                    <asp:TextBox id="pNo3" placeholder="Mobile Number" style="width:10%" maxlength="4" value="" runat="server" />&nbsp
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="control-label col-md-3">Email
                                                </label>
                                                <div class="col-md-5">
                                                    <div class="input-group">
                                                        <asp:TextBox runat="server" class="form-control input-height" id="email" value="" placeholder="Email Address" />
                                                    </div>
                                                </div>
                                            </div>
                                            Address<br />
                                             <div class="form-group row">
                                                <label class="control-label col-md-3">Street
                                                    <span class="required"> * </span>
                                                </label>
                                                <div class="col-md-5">
                                                    <asp:TextBox runat="server" id="street" placeholder="Street Address" class="form-control input-height" />
                                                </div>
                                            </div>
                                             <div class="form-group row">
                                                <label class="control-label col-md-3">Street 2</label>
                                                <div class="col-md-5">
                                                    <asp:TextBox runat="server" id="street2" placeholder="Apt # etc.." class="form-control input-height" />
                                                </div>
                                            </div>
                                             <div class="form-group row">
                                                <label class="control-label col-md-3">City
                                                    <span class="required"> * </span>
                                                </label>
                                                <div class="col-md-5">
                                                    <asp:TextBox runat="server" id="city" placeholder="City" class="form-control input-height" />
                                                </div>
                                            </div>
                                             <div class="form-group row">
                                                <label class="control-label col-md-3">State
                                                    <span class="required"> * </span>
                                                </label>
                                                <div class="col-md-5">
                                                    <asp:DropDownList ID="state" runat="server" style="width:100%" class="form-control input-height" >
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
                                                </div>
                                            </div>
                                             <div class="form-group row">
                                                <label class="control-label col-md-3">Zip
                                                    <span class="required"> * </span>
                                                </label>
                                                <div class="col-md-5">
                                                    <asp:TextBox runat="server" id="zip" placeholder="Zip Code" class="form-control input-height" />
                                                </div>
                                            </div>
                                            <div class="form-actions">
                                                <span id="resultOut" runat="server"></span>
                                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" HeaderText="Please check and correct these fields:" DisplayMode="List" />
                                                <asp:RegularExpressionValidator ID="pNoValidator1" runat="server" ErrorMessage="Phone Number - Area Code must be 3 digits only" ControlToValidate="pNo1" ValidationExpression="\d{3}" Display="None" ></asp:RegularExpressionValidator>
                                                <asp:RegularExpressionValidator ID="pNoValidator2" runat="server" ErrorMessage="Phone Number - Middle 3 must be 3 digits only" ControlToValidate="pNo2" ValidationExpression="\d{3}" Display="None"></asp:RegularExpressionValidator>
                                                <asp:RegularExpressionValidator ID="pNoValidator3" runat="server" ErrorMessage="Phone Number - Last 4 must be 4 digits only" ControlToValidate="pNo3" ValidationExpression="\d{4}" Display="None"></asp:RegularExpressionValidator>
                                                <asp:RegularExpressionValidator ID="emailValidator" runat="server" ErrorMessage="Email Address isn't complete" ControlToValidate="email" Display="None" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                <asp:RegularExpressionValidator ID="zipValidator" runat="server" ErrorMessage="Zip Code must be 5 digits only" ValidationExpression="\d{5}" Display="None" ControlToValidate="zip"></asp:RegularExpressionValidator>
                                                
                                                <asp:RequiredFieldValidator ID="emailRequiredValidator" runat="server" ErrorMessage="Email Address is required" ControlToValidate="email" Display="None"></asp:RequiredFieldValidator>
                                                <asp:RequiredFieldValidator ID="pNo1RequiredValidator" runat="server" ErrorMessage="Phone Area Code is required" ControlToValidate="pNo1" Display="None"></asp:RequiredFieldValidator>
                                                <asp:RequiredFieldValidator ID="pNo2RequiredValidator" runat="server" ErrorMessage="Phone middle 3 digits are required" ControlToValidate="pNo2" Display="None"></asp:RequiredFieldValidator>
                                                <asp:RequiredFieldValidator ID="pNo3RequiredValidator" runat="server" ErrorMessage="Phone last 4 digits are required" ControlToValidate="pNo3" Display="None"></asp:RequiredFieldValidator>
                                                <asp:RequiredFieldValidator ID="streetRequiredValidator" runat="server" ErrorMessage="Street is required" ControlToValidate="street" Display="None"></asp:RequiredFieldValidator>
                                                <asp:RequiredFieldValidator ID="cityRequiredValidator" runat="server" ErrorMessage="City is required" ControlToValidate="city" Display="None"></asp:RequiredFieldValidator>
                                                <asp:RequiredFieldValidator ID="stateRequiredValidator" runat="server" ErrorMessage="State is required" ControlToValidate="state" Display="None"></asp:RequiredFieldValidator>
                                                <asp:RequiredFieldValidator ID="zipRequiredValidator" runat="server" ErrorMessage="Zip Code is required" ControlToValidate="zip" Display="None"></asp:RequiredFieldValidator>
                                            <div class="row">
                                                <div class="offset-md-3 col-md-9">
                                                    <asp:button runat="server" type="submit" class="btn btn-info" Text="Submit" OnClick="validate"></asp:button>
                                                    <asp:button runat="server" type="button" class="btn btn-default" Text="Cancel" PostBackUrl="pat_profile.aspx"></asp:button>
                                                </div>
                                            	</div>
                                        	</div>
										</div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- end page content -->
            <!-- start chat sidebar -->
            <div class="chat-sidebar-container" data-close-on-body-click="false">
                <div class="chat-sidebar">
                    <ul class="nav nav-tabs">
                        <li class="nav-item">
                            <a href="#quick_sidebar_tab_1" class="nav-link active tab-icon"  data-toggle="tab">Theme</a>
                        </li>
                        <li class="nav-item">
                            <a href="#quick_sidebar_tab_2" class="nav-link tab-icon"  data-toggle="tab">Settings</a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <!-- Start Color Theme Sidebar -->
                    	<div class="tab-pane chat-sidebar-settings in show active animated shake" role="tabpanel" id="quick_sidebar_tab_1">
							<div class="chat-sidebar-slimscroll-style">
								<div class="theme-light-dark">
									<h6>Sidebar Theme</h6>
									<button type="button" data-theme="white" class="btn lightColor btn-outline btn-circle m-b-10 theme-button">Light Sidebar</button>
									<button type="button" data-theme="dark" class="btn dark btn-outline btn-circle m-b-10 theme-button">Dark Sidebar</button>
								</div>
								<div class="theme-light-dark">
									<h6>Sidebar Color</h6>
									<ul class="list-unstyled">
										<li class="complete">
											<div class="theme-color sidebar-theme">
												<a href="#" data-theme="white"><span class="head"></span><span class="cont"></span></a>
												<a href="#" data-theme="dark"><span class="head"></span><span class="cont"></span></a>
												<a href="#" data-theme="blue"><span class="head"></span><span class="cont"></span></a>
												<a href="#" data-theme="indigo"><span class="head"></span><span class="cont"></span></a>
												<a href="#" data-theme="cyan"><span class="head"></span><span class="cont"></span></a>
												<a href="#" data-theme="green"><span class="head"></span><span class="cont"></span></a>
												<a href="#" data-theme="red"><span class="head"></span><span class="cont"></span></a>
											</div>
										</li>
									</ul>
									<h6>Header Brand color</h6>
									<ul class="list-unstyled">
										<li class="theme-option">
											<div class="theme-color logo-theme">
								             	<a href="#" data-theme="logo-white"><span class="head"></span><span class="cont"></span></a>
												<a href="#" data-theme="logo-dark"><span class="head"></span><span class="cont"></span></a>
												<a href="#" data-theme="logo-blue"><span class="head"></span><span class="cont"></span></a>
												<a href="#" data-theme="logo-indigo"><span class="head"></span><span class="cont"></span></a>
												<a href="#" data-theme="logo-cyan"><span class="head"></span><span class="cont"></span></a>
												<a href="#" data-theme="logo-green"><span class="head"></span><span class="cont"></span></a>
												<a href="#" data-theme="logo-red"><span class="head"></span><span class="cont"></span></a>
								           	</div>
								        </li>
									</ul>
									<h6>Header color</h6>
									<ul class="list-unstyled">
										<li class="theme-option">
											<div class="theme-color header-theme">
								             	<a href="#" data-theme="header-white"><span class="head"></span><span class="cont"></span></a>
								             	<a href="#" data-theme="header-dark"><span class="head"></span><span class="cont"></span></a>
								             	<a href="#" data-theme="header-blue"><span class="head"></span><span class="cont"></span></a>
								             	<a href="#" data-theme="header-indigo"><span class="head"></span><span class="cont"></span></a>
								             	<a href="#" data-theme="header-cyan"><span class="head"></span><span class="cont"></span></a>
								             	<a href="#" data-theme="header-green"><span class="head"></span><span class="cont"></span></a>
								             	<a href="#" data-theme="header-red"><span class="head"></span><span class="cont"></span></a>
								          	</div>
								        </li>
									</ul>
								</div>
							</div>
						</div>
						<!-- End Color Theme Sidebar -->
 						<!-- Start Setting Panel --> 
 						<div class="tab-pane chat-sidebar-settings" role="tabpanel" id="quick_sidebar_tab_2">
                           <div class="chat-sidebar-settings-list chat-sidebar-slimscroll-style">
                                <div class="chat-header"><h5 class="list-heading">Layout Settings</h5></div>
	                            <div class="chatpane inner-content ">
									<div class="settings-list">
					                    <div class="setting-item">
					                        <div class="setting-text">Sidebar Position</div>
					                        <div class="setting-set">
					                           <select class="sidebar-pos-option form-control input-inline input-sm input-small ">
	                                                <option value="left" selected="selected">Left</option>
	                                                <option value="right">Right</option>
                                            	</select>
					                        </div>
					                    </div>
					                    <div class="setting-item">
					                        <div class="setting-text">Header</div>
					                        <div class="setting-set">
					                           <select class="page-header-option form-control input-inline input-sm input-small ">
	                                                <option value="fixed" selected="selected">Fixed</option>
	                                                <option value="default">Default</option>
                                            	</select>
					                        </div>
					                    </div>
					                    <div class="setting-item">
					                        <div class="setting-text">Sidebar Menu </div>
					                        <div class="setting-set">
					                           <select class="sidebar-menu-option form-control input-inline input-sm input-small ">
	                                                <option value="accordion" selected="selected">Accordion</option>
	                                                <option value="hover">Hover</option>
                                            	</select>
					                        </div>
					                    </div>
					                    <div class="setting-item">
					                        <div class="setting-text">Footer</div>
					                        <div class="setting-set">
					                           <select class="page-footer-option form-control input-inline input-sm input-small ">
	                                                <option value="fixed">Fixed</option>
	                                                <option value="default" selected="selected">Default</option>
                                            	</select>
					                        </div>
					                    </div>
					                </div>
									<div class="chat-header"><h5 class="list-heading">Account Settings</h5></div>
									<div class="settings-list">
					                    <div class="setting-item">
					                        <div class="setting-text">Notifications</div>
					                        <div class="setting-set">
					                            <div class="switch">
					                                <label class = "mdl-switch mdl-js-switch mdl-js-ripple-effect" 
									                  for = "switch-1">
									                  <input type = "checkbox" id = "switch-1" 
									                     class = "mdl-switch__input" checked>
									               	</label>
					                            </div>
					                        </div>
					                    </div>
					                    <div class="setting-item">
					                        <div class="setting-text">Show Online</div>
					                        <div class="setting-set">
					                            <div class="switch">
					                                <label class = "mdl-switch mdl-js-switch mdl-js-ripple-effect" 
									                  for = "switch-7">
									                  <input type = "checkbox" id = "switch-7" 
									                     class = "mdl-switch__input" checked>
									               	</label>
					                            </div>
					                        </div>
					                    </div>
					                    <div class="setting-item">
					                        <div class="setting-text">Status</div>
					                        <div class="setting-set">
					                            <div class="switch">
					                                <label class = "mdl-switch mdl-js-switch mdl-js-ripple-effect" 
									                  for = "switch-2">
									                  <input type = "checkbox" id = "switch-2" 
									                     class = "mdl-switch__input" checked>
									               	</label>
					                            </div>
					                        </div>
					                    </div>
					                    <div class="setting-item">
					                        <div class="setting-text">2 Steps Verification</div>
					                        <div class="setting-set">
					                            <div class="switch">
					                                <label class = "mdl-switch mdl-js-switch mdl-js-ripple-effect" 
									                  for = "switch-3">
									                  <input type = "checkbox" id = "switch-3" 
									                     class = "mdl-switch__input" checked>
									               	</label>
					                            </div>
					                        </div>
					                    </div>
					                </div>
                                    <div class="chat-header"><h5 class="list-heading">General Settings</h5></div>
                                    <div class="settings-list">
					                    <div class="setting-item">
					                        <div class="setting-text">Location</div>
					                        <div class="setting-set">
					                            <div class="switch">
					                                <label class = "mdl-switch mdl-js-switch mdl-js-ripple-effect" 
									                  for = "switch-4">
									                  <input type = "checkbox" id = "switch-4" 
									                     class = "mdl-switch__input" checked>
									               	</label>
					                            </div>
					                        </div>
					                    </div>
					                    <div class="setting-item">
					                        <div class="setting-text">Save Histry</div>
					                        <div class="setting-set">
					                            <div class="switch">
					                                <label class = "mdl-switch mdl-js-switch mdl-js-ripple-effect" 
									                  for = "switch-5">
									                  <input type = "checkbox" id = "switch-5" 
									                     class = "mdl-switch__input" checked>
									               	</label>
					                            </div>
					                        </div>
					                    </div>
					                    <div class="setting-item">
					                        <div class="setting-text">Auto Updates</div>
					                        <div class="setting-set">
					                            <div class="switch">
					                                <label class = "mdl-switch mdl-js-switch mdl-js-ripple-effect" 
									                  for = "switch-6">
									                  <input type = "checkbox" id = "switch-6" 
									                     class = "mdl-switch__input" checked>
									               	</label>
					                            </div>
					                        </div>
					                    </div>
					                </div>
	                        	</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
                <!-- end chat sidebar -->
            </div>
            <!-- end page container -->
            <!-- start footer -->
            <div class="page-footer">
                <div class="page-footer-inner"> 2018 &copy; Sunray Template By
                    <a href="mailto:redstartheme@gmail.com" target="_top" class="makerCss">Redstar Theme</a>
                </div>
                <div class="scroll-to-top">
                    <i class="material-icons">eject</i>
                </div>
            </div>
            <!-- end footer -->
        </div></div>
        <!-- start js include path -->
	<script src="plugins/jquery/jquery.min.js"></script>
	<script src="plugins/popper/popper.min.js"></script>
	<script src="plugins/jquery-blockui/jquery.blockui.min.js"></script>
	<script src="plugins/jquery-slimscroll/jquery.slimscroll.js"></script>
	<script src="plugins/sparkline/jquery.sparkline.min.js"></script>
	<!-- bootstrap -->
	<script src="plugins/bootstrap/js/bootstrap.min.js"></script>
	<!-- Common js-->
	<script src="js/app.js"></script>
	<script src="js/pages/profile/profile.js"></script>
	<script src="js/layout.js"></script>
	<script src="js/theme-color.js"></script>
	<!-- Material -->
	<script src="plugins/material/material.min.js"></script>
	<script src="plugins/sparkline/jquery.sparkline.min.js"></script>
	<script src="js/pages/sparkline/sparkline-data.js"></script>
	<!-- end js include path -->
</body>
</html>