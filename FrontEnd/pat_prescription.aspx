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
        string token = Request.QueryString.Get("token");

        //Get user cookie data
        HttpCookie uInfo = Request.Cookies["uInfo"];
        if(uInfo != null)
        {
            //If successful, set up page data
            loadUserData(uInfo); //TODO: Ensure this loads on initial page load
            loadPrescriptionTable(uInfo);
        }
        else
        {
            //Silently note that an error occured
            namePlate.InnerHtml = "<p>" + User_EID + "</p><small>Doctor</small>";
        }

        if(token != null && token.Length > 0)
        {
            makeRefill(uInfo);
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
        }
        objDataReader.Close();
        myConnection.Close();
    }
    void loadPrescriptionTable(HttpCookie uInfo)
    {
        //Loads components specific to prescriptions for this patient
        string strSelect;
        string strConnect;
        string refFilled;
        string refAllowed;

        strSelect ="SELECT Pre_ID, Pre_Name, Pre_Refills_Allowed, Pre_Refills_Filled, Appt_Date, Doc_Name_F, Doc_Name_L FROM patient p, appointment a, prescription pr, doctor d WHERE pr.Pre_Appt_ID = a.Appt_ID AND p.Pat_ID = a.Appt_Pat_ID AND d.Doc_ID = a.Appt_Doc_ID AND Pre_Deleted <> 1 AND p.Pat_ID = @EID";
        strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";

        SqlConnection myConnection = new SqlConnection(strConnect);
        myConnection.Open();
        SqlCommand myCommand = new SqlCommand(strSelect, myConnection);
        myCommand.Parameters.AddWithValue( "@EID", uInfo["EID"].ToString());

        SqlDataReader objDataReader;
        objDataReader = myCommand.ExecuteReader();

        //Build the table
        string tableOut = "<table id='tableExport' class='display table table-hover table-checkable order-column m-t-20' style='width:100%'>";
        tableOut += "<thead><tr><td>Prescription Name</td><td>Date Prescribed</td><td>Doctor Name</td><td>Times Filled</td><td>Fills Allowed</td><td>Request Refill</td></tr></thead>";
        while(objDataReader.Read())
        {
            refFilled = objDataReader["Pre_Refills_Filled"].ToString();
            refAllowed = objDataReader["Pre_Refills_Allowed"].ToString();

            tableOut += "<tr class='odd gradeX'>";
            tableOut += "<td>" + objDataReader["Pre_Name"].ToString() + "</td>";
            tableOut += "<td>" + objDataReader["Appt_Date"].ToString() + "</td>";
            tableOut += "<td>" + objDataReader["Doc_Name_F"].ToString() + " " + objDataReader["Doc_Name_L"].ToString() + "</td>";
            tableOut += "<td>" + refFilled + "</td>";
            tableOut += "<td>" + refAllowed + "</td>";
            if(Convert.ToInt32(refAllowed) > Convert.ToInt32(refFilled))
            {
                tableOut += "<td><a href='pat_prescription.aspx?token=" + objDataReader["Pre_ID"].ToString() + "'>Request</a></td>";
            }
            else
            {
                tableOut += "<td>Out of Refills!</td>";
            }
            tableOut += "</tr>";
        }
        tableOut += "</table>";

        //Set page placeholders
        tableZone.InnerHtml = tableOut;
        objDataReader.Close();
        myConnection.Close();
    }
    void makeRefill(HttpCookie uInfo)
    {
        int numa;
        String strConnect = "server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";

        String strSelect = "Select * from prescription where Pre_ID = @tok";
        try
        {
            SqlConnection myConnection = new SqlConnection(strConnect);
            SqlCommand myCommand = new SqlCommand(strSelect, myConnection);

            myCommand.Parameters.AddWithValue("@tok", Request.QueryString.Get("token"));

            myConnection.Open();

            SqlDataReader objDataReader;
            objDataReader = myCommand.ExecuteReader();

            if (objDataReader.Read())
            {
                if (Convert.ToInt32(objDataReader["Pre_Refills_Allowed"].ToString()) == Convert.ToInt32(objDataReader["Pre_Refills_Filled"].ToString()))
                    return;
            }
            myConnection.Close();
            resultOut.InnerHtml = "Request sent!";
        }
        catch(Exception ex)
        {
            resultOut.InnerHtml = "Request Unsuccessful.<br>Error Code: " + ex.ToString();
        }

        String strInsert = "Insert into email (Email_Message,Email_Deleted) VALUES (@message, 0)";
        try
        {
            SqlConnection myConnection = new SqlConnection(strConnect);
            SqlCommand myCommand = new SqlCommand(strInsert, myConnection);

            myCommand.Parameters.AddWithValue("@message", "Prescription Request Mail sent for Patient " + uInfo["EID"].ToString());

            myConnection.Open();
            numa = myCommand.ExecuteNonQuery();
            myConnection.Close();
        }
        catch(Exception ex)
        {
            resultOut.InnerHtml = "Request Unsuccessful.<br>Error Code: " + ex.ToString();
            return;
        }

        String strUpdate = "Update prescription set Pre_Refills_Filled = (Pre_Refills_Filled + 1) where Pre_ID = @tok";
        try
        {
            SqlConnection myConnection = new SqlConnection(strConnect);
            SqlCommand myCommand = new SqlCommand(strUpdate, myConnection);

            myCommand.Parameters.AddWithValue("@tok", Request.QueryString.Get("token"));

            myConnection.Open();
            numa = myCommand.ExecuteNonQuery();
            myConnection.Close();
            resultOut.InnerHtml = "Request sent!";
        }
        catch(Exception ex)
        {
            resultOut.InnerHtml = "Request Unsuccessful.<br>Error Code: " + ex.ToString();
        }
    }
</script>
 <!-- END HEAD -->
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
                                <div class="page-title">My Prescriptions</div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card  card-box">
                                <div class="card-body ">
                                    <div class="table-scrollable" id="tableZone" runat="server">
                                        
                                    </div>
                                    <span id="resultOut" runat="server"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- end page content -->
        </div>
        <!-- end page container -->
    </div>
    <!-- start js include path -->
    <script src="plugins/jquery/jquery.min.js"></script>
    <script src="plugins/popper/popper.min.js"></script>
    <script src="plugins/jquery-blockui/jquery.blockui.min.js"></script>
    <script src="plugins/jquery-slimscroll/jquery.slimscroll.js"></script>
    <!-- bootstrap -->
    <script src="plugins/bootstrap/js/bootstrap.min.js"></script>
    <!-- data tables -->
    <script src="plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="plugins/datatables/plugins/bootstrap/dataTables.bootstrap4.min.js"></script>
    <script src="js/pages/table/table_data.js"></script>
    <!-- Common js-->
    <script src="js/app.js"></script>
    <script src="js/layout.js"></script>
    <script src="js/theme-color.js"></script>
    <!-- Material -->
    <script src="plugins/material/material.min.js"></script>
    <!-- end js include path -->
</body>
</html>