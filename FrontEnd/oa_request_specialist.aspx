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
    <title>StarCare Admin Dashboard</title>
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
        string token = Request.QueryString.Get("token");

        //Get user cookie data
        HttpCookie uInfo = Request.Cookies["uInfo"];
        if(uInfo != null)
        {
            //If successful, set up page data
            loadUserData(uInfo); //TODO: Ensure this loads on initial page load
            checkApproval();
        }
        else
        {
            //Silently note that an error occured
            namePlate.InnerHtml = "<p>" + User_EID + "</p><small>Admin</small>";
        }
        if(token != null && token.Length > 0 && token == "yes")
        {
            sendRequest(Request.QueryString.Get("patid"),Request.QueryString.Get("docid"));
        }
    }
    void loadUserData(HttpCookie uInfo)
    {
        //Loads components specific to the current user
        string strSelect;
        string strConnect;

        strSelect ="SELECT * FROM office_admin WHERE OA_ID = @EID";
        strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";

        SqlConnection myConnection = new SqlConnection(strConnect);
        myConnection.Open();
        SqlCommand myCommand = new SqlCommand(strSelect, myConnection);
        myCommand.Parameters.AddWithValue( "@EID", uInfo["EID"].ToString());

        SqlDataReader objDataReader;
        objDataReader = myCommand.ExecuteReader();
        if (objDataReader.Read())
        {
            string fName = objDataReader["OA_Name_F"].ToString();
            string lName = objDataReader["OA_Name_L"].ToString();
            string role = objDataReader["OA_Role"].ToString();

            //Set page placeholders
            namePlate.InnerHtml = "<p>" + fName + " " + lName + "</p><small>" + role + "</small>";
        }
        objDataReader.Close();
        myConnection.Close();
    }
    void checkApproval(){
        string patid = Request.QueryString.Get("patid");
        string docid = Request.QueryString.Get("docid");
        string token = Request.QueryString.Get("token");

        string strSelect;
        string strConnect;

        strSelect ="SELECT * FROM approval WHERE App_Doc_ID = @docid AND App_Pat_ID = @patid";
        strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";

        SqlConnection myConnection = new SqlConnection(strConnect);
        myConnection.Open();
        SqlCommand myCommand = new SqlCommand(strSelect, myConnection);
        myCommand.Parameters.AddWithValue( "@patid", patid);
        myCommand.Parameters.AddWithValue( "@docid", docid);

        SqlDataReader objDataReader;
        objDataReader = myCommand.ExecuteReader();

        if (objDataReader.Read())
        {
            if(objDataReader["App_Given"].ToString() == "True"){
                resultMessage.InnerHtml = "<font color=\"green\">Request with this specialist has already been accepted. Please proceed booking appointment.</font>";
                tableZone.InnerHtml = "<br><a href='oa_book_appointment.aspx?&docid=" + docid + "&patid=" + patid + "' class='btn btn-tbl btn-xs'><i>Book Appointment</i></a></td>";
            }
            else if(objDataReader["App_Given"].ToString() == "False"){
                // loadApprovedTable(patid, docid);
                //if rejected
                // tableZone.InnerHtml = "<table id='table' class='table table-hover table-checkable order-column full-width' style='width:100%'><thead><tr><td style='width:30%'>Request Rejected</td></tr></thead>";
                resultMessage.InnerHtml = "<font color=\"red\">Request with this specialist has already been rejected. Please select a different doctor or send a new request.</font>";
                loadReqTable();
            }
            else if(token != null && token == "yes"){
                loadReqTable();
            }
            else if(objDataReader["App_Given"].ToString().Length <  1){
                resultMessage.InnerHtml = "<font color=\"blue\">You have a pending request to see this doctor. Please wait for approval.</font>";
            }
            else{
                tableZone.InnerHtml = "<div>Error loading table. Please try again or contact IT.</div>";
            }
        }
        else{
            loadReqTable();
        }
        objDataReader.Close();
        myConnection.Close();

    }
    void sendRequest(string patid, string docid){
        string strInsert;
        string strConnect;
        string strSelect;

        strSelect ="select * FROM approval WHERE App_Pat_ID = @patid AND App_Doc_ID = @docid AND App_Spec_ID = 1";
        strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";

        SqlConnection myConnectionA = new SqlConnection(strConnect);
        myConnectionA.Open();
        SqlCommand myCommandA = new SqlCommand(strSelect, myConnectionA);
        myCommandA.Parameters.AddWithValue( "@patid", patid);
        myCommandA.Parameters.AddWithValue( "@docid", docid);

        SqlDataReader objDataReader;
        objDataReader = myCommandA.ExecuteReader();
        if (objDataReader.Read()) //Prevent duplicate aproval records
        {
            myConnectionA.Close();
            return;
        }
        myConnectionA.Close();
        objDataReader.Close();

        strInsert ="INSERT INTO approval (App_Pat_ID, App_Doc_ID, App_Spec_ID) VALUES(@patid, @docid, 1)";
        strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";

        SqlConnection myConnection = new SqlConnection(strConnect);
        myConnection.Open();
        SqlCommand myCommand = new SqlCommand(strInsert, myConnection);
        myCommand.Parameters.AddWithValue( "@patid", patid);
        myCommand.Parameters.AddWithValue( "@docid", docid);

        myCommand.ExecuteNonQuery();
        myConnection.Close();
    }
    void loadReqTable()
    {
        //Loads components specific to appointment count
        string strSelect;
        string strConnect;
        string token = Request.QueryString.Get("token");
        string patid = Request.QueryString.Get("patid");
        string docid = Request.QueryString.Get("docid");

        strSelect ="SELECT Doc_ID, Doc_Name_F, Doc_Name_L, Doc_Email, Doc_Phone, Doc_Specialization, Doc_Addr_City, Doc_Addr_State FROM doctor WHERE Doc_ID = @docid";
        strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";

        SqlConnection myConnection = new SqlConnection(strConnect);
        myConnection.Open();
        SqlCommand myCommand = new SqlCommand(strSelect, myConnection);
        myCommand.Parameters.AddWithValue("@docid", docid);

        SqlDataReader objDataReader;
        objDataReader = myCommand.ExecuteReader();

        //Build the appointment table
        string tableOut = "<table id='table' class='table table-hover table-checkable order-column full-width' style='width:100%'>";
        tableOut += "<thead><tr><td style='width:30%'>Doctor Name</td><td>Specialization</td><td>Location</td><td>Email</td><td>Phone</td><td>Request Specialist</td></tr></thead>";
        while(objDataReader.Read())
        {
            tableOut += "<tr class='odd gradeX'>";
            tableOut += "<td>" + objDataReader["Doc_Name_F"].ToString() + " " + objDataReader["Doc_Name_L"].ToString() + "</td>";
            tableOut += "<td>" + objDataReader["Doc_Specialization"].ToString() + "</td>";
            tableOut += "<td>" + objDataReader["Doc_Addr_City"].ToString() + ", " + objDataReader["Doc_Addr_State"].ToString() + "</td>";
            tableOut += "<td>" + objDataReader["Doc_Email"].ToString() + "</td>";
            tableOut += "<td>" + objDataReader["Doc_Phone"].ToString() + "</td>";
            if(token != null && token.Length > 0 && token == "yes"){
                tableOut += "<td>Request sent</td>";
            } else
            {
                tableOut += "<td><a href='oa_request_specialist.aspx?&token=yes&patid=" + patid + "&docid=" + docid +"'class='btn btn-tbl-edit btn-xs'><i class='fa fa-check'></i></td>";
                tableOut += "<td><a href='oa_select_doctor.aspx?&patid=" + patid + "' class='btn btn-tbl-delete btn-xs'><i class='fa fa-times'></i></td>";
                tableOut += "</tr>";
            }
        }
        tableOut += "</table>";

        //Set page placeholders
        tableZone.InnerHtml = tableOut;
        objDataReader.Close();
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
                    <a href="oa_profile.aspx">
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
                            <li class="nav-item active open">
                                <a href="#" class="nav-link nav-toggle">
                                    <i class="material-icons">dashboard</i>
                                    <span class="title">Main</span>
                                    <span class="selected"></span>
                                    <span class="arrow open"></span>
                                </a>
                                <ul class="sub-menu">
                                    <li class="nav-item  active open">
                                        <a href="oa_ui.aspx" class="nav-link ">
                                            <span class="title">Dashboard</span>
                                            <span class="selected"></span>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item  ">
                                <a href="#" class="nav-link nav-toggle"><i class="material-icons">assignment</i>
                                    <span class="title">Appointment</span><span class="arrow"></span></a>
                                <ul class="sub-menu">

                                    <li class="nav-item  ">
                                        <a href="oa_special_appointment.aspx" class="nav-link "><span class="title">Specialist Appointments</span>
                                        </a>
                                    </li>
                                    <li class="nav-item  ">
                                        <a href="oa_select_patient.aspx" class="nav-link "><span class="title">Book Appointment</span>
                                        </a>
                                    </li>
                                    <li class="nav-item  ">
                                        <a href="oa_current_appointment.aspx" class="nav-link "><span class="title">Upcoming Appointments</span>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item  ">
                                <a href="#" class="nav-link nav-toggle"><i class="material-icons">person</i>
                                    <span class="title">Doctors</span> <span class="arrow"></span>
                                </a>
                                <ul class="sub-menu">
                                    <li class="nav-item  ">
                                        <a href="oa_all_doctors.aspx" class="nav-link "><span class="title">All Doctor</span>
                                        </a>
                                    </li>
                                    <li class="nav-item  ">
                                        <a href="oa_add_doctor.aspx" class="nav-link "><span class="title">Add Doctor</span>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item  ">
                                <a href="#" class="nav-link nav-toggle"><i class="material-icons">group</i>
                                    <span class="title">Clinic Staff</span> <span class="arrow"></span>
                                </a>
                                <ul class="sub-menu">
                                    <li class="nav-item  ">
                                        <a href="oa_all_staffs.aspx" class="nav-link "><span class="title">All Staff</span>
                                        </a>
                                    </li>
                                    <li class="nav-item  ">
                                        <a href="oa_add_staff.aspx" class="nav-link "><span class="title">Add Staff</span>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item  ">
                                <a href="#" class="nav-link nav-toggle"><i class="material-icons">accessible</i>
                                    <span class="title">Patients</span> <span class="arrow"></span>
                                </a>
                                <ul class="sub-menu">
                                    <li class="nav-item  ">
                                        <a href="oa_all_patients.aspx" class="nav-link "><span class="title">All Patients</span>
                                        </a>
                                    </li>
                                    <li class="nav-item  ">
                                        <a href="oa_add_patient.aspx" class="nav-link "><span class="title">Add Patient</span>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item  ">
                                <a href="#" class="nav-link nav-toggle"><i class="material-icons">report</i>
                                    <span class="title">Reports</span> <span class="arrow"></span>
                                </a>
                                <ul class="sub-menu">
                                    <li class="nav-item  ">
                                        <a href="oa_report_year.aspx" class="nav-link "><span class="title">This Year</span>
                                        </a>
                                    </li>
									<li class="nav-item  ">
                                        <a href="oa_report_month.aspx" class="nav-link "><span class="title">This Month</span>
                                        </a>
                                    </li>
									<li class="nav-item  ">
                                        <a href="oa_report_today.aspx" class="nav-link "><span class="title">Today</span>
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
                                <div class="page-title">Doctor List</div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tabbable-line"> 
                                <div class="tab-content">
                                    <div class="tab-pane active fontawesome-demo" id="tab1">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="card  card-box">
                                                    <div class="card-head">
                                                        <header></header>
                                                        <div class="tools">
                                                            <a class="fa fa-repeat btn-color box-refresh" href="javascript:;"></a>
                                                            <a class="t-collapse btn-color fa fa-chevron-down" href="javascript:;"></a>
                                                            <a class="t-close btn-color fa fa-times" href="javascript:;"></a>
                                                        </div>
                                                    </div>
                                                    <div class="card-body ">
                                                        <div class="table-scrollable" id="resultMessage" runat="server">
                                                        </div>
                                                        <div class="table-scrollable" id="tableZone" runat="server">
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
    </div>
    <!-- start js include path -->
    <script src="plugins/jquery/jquery.min.js" ></script>
    <script src="plugins/popper/popper.min.js" ></script>
    <script src="plugins/jquery-blockui/jquery.blockui.min.js" ></script>
    <script src="plugins/jquery-slimscroll/jquery.slimscroll.js"></script>
    <!-- bootstrap -->
    <script src="plugins/bootstrap/js/bootstrap.min.js" ></script>
    <!-- data tables -->
    <script src="plugins/datatables/jquery.dataTables.min.js" ></script>
    <script src="plugins/datatables/plugins/bootstrap/dataTables.bootstrap4.min.js" ></script>
    <script src="js/pages/table/table_data.js" ></script>
    <!-- Common js-->
    <script src="js/app.js" ></script>
    <script src="js/layout.js" ></script>
    <script src="js/theme-color.js" ></script>
    <!-- Material -->
    <script src="plugins/material/material.min.js"></script>
     <!-- end js include path -->
</body>
</html>