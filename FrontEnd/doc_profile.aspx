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
    <title>StarCare</title>
    <!-- google font -->
    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet" type="text/css" />
    <!-- icons -->
    <link href="fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <!--bootstrap -->
    <link href="plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Material Design Lite CSS -->
    <link href="plugins/material/material.min.css" rel="stylesheet">
    <link href="css/material_style.css" rel="stylesheet">
    <!-- Theme Styles -->
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="css/plugins.min.css" rel="stylesheet" type="text/css" />
    <link href="css/responsive.css" rel="stylesheet" type="text/css" />
    <link href="css/theme-color.css" rel="stylesheet" type="text/css" />

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
        if (uInfo != null) {
            //If successful, set up page data
            loadUserData(uInfo); //TODO: Ensure this loads on initial page load
        }
        else {
            //Silently note that an error occured
            namePlate.InnerHtml = "<p>" + User_EID + "</p><small>Doctor</small>";
        }
    }
    void loadUserData(HttpCookie uInfo)
    {
        //Loads components specific to the current user
        string strSelect;
        string strConnect;

        strSelect = "SELECT * FROM doctor WHERE Doc_ID = @EID";
        strConnect = "server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";

        SqlConnection myConnection = new SqlConnection(strConnect);
        myConnection.Open();
        SqlCommand myCommand = new SqlCommand(strSelect, myConnection);
        myCommand.Parameters.AddWithValue("@EID", uInfo["EID"].ToString());

        SqlDataReader objDataReader;
        objDataReader = myCommand.ExecuteReader();
        if (objDataReader.Read()) {
            string fName = objDataReader["Doc_Name_F"].ToString();
            string lName = objDataReader["Doc_Name_L"].ToString();
            string spec = objDataReader["Doc_Specialization"].ToString();

            DateTime doc_dob = Convert.ToDateTime(objDataReader["Doc_DOB"]);

            //Set page placeholders
            namePlate.InnerHtml = "<p>" + fName + " " + lName + "</p><small>" + spec + "</small>";
            name.InnerHtml = fName + " " + lName;
            specField.InnerHtml = spec;
            gender.InnerHtml = objDataReader["Doc_Gender"].ToString();
            dob.InnerHtml = doc_dob.ToShortDateString();
            email.InnerHtml = objDataReader["Doc_Email"].ToString();
            phone.InnerHtml = objDataReader["Doc_Phone"].ToString();
            street.InnerHtml = objDataReader["Doc_Addr_Street"].ToString();
            street2.InnerHtml = objDataReader["Doc_Addr_2"].ToString();
            city.InnerHtml = objDataReader["Doc_Addr_City"].ToString();
            state.InnerHtml = objDataReader["Doc_Addr_State"].ToString();
            zip.InnerHtml = objDataReader["Doc_Addr_Zip"].ToString();
        }
        else {
            namePlate.InnerHtml = "Error opening record set. " + uInfo["EID"].ToString();
        }
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
                    <a href="doc_ui.aspx">
                        <span class="logo-default">StarCare</span> </a>
                </div>
                <!-- logo end -->
                <ul class="nav navbar-nav navbar-left in">
                    <li><a href="#" class="menu-toggler sidebar-toggler font-size-20"><i class="fa fa-exchange"
                                aria-hidden="true"></i></a></li>
                </ul>
                <ul class="nav navbar-nav navbar-left in">
                    <!-- start full screen button -->
                    <li><a href="javascript:;" class="fullscreen-click font-size-20"><i
                                class="fa fa-arrows-alt"></i></a></li>
                    <!-- end full screen button -->
                </ul>
                <!-- start mobile menu -->
                <a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse"
                    data-target=".navbar-collapse">
                    <span></span>
                </a>
                <!-- end mobile menu -->
                <!-- start header menu -->
                <div class="top-menu">
                    <ul class="nav navbar-nav pull-right">
                        <!-- start manage user dropdown -->
                        <li class="dropdown dropdown-user">
                            <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"
                                data-close-others="true">
                                <img alt="" class="img-circle " src="img/dp.jpg" />
                            </a>
                            <ul class="dropdown-menu dropdown-menu-default">
                                <li>
                                    <a href="login.aspx">
                                        <i class="fa fa-sign-out"></i> Log Out </a>
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
                        <ul class="sidemenu  page-header-fixed slimscroll-style" data-keep-expanded="true"
                            data-auto-scroll="true" data-slide-speed="200" style="padding-top: 20px">
                            <li class="sidebar-toggler-wrapper hide">
                                <div class="sidebar-toggler">
                                    <span></span>
                                </div>
                            </li>
                            <li class="sidebar-user-panel">
                                <div class="user-panel">
                                    <div class="pull-left info" id="namePlate" runat="server"></div>
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
                                    <li class="nav-item">
                                        <a href="doc_ui.aspx" class="nav-link ">
                                            <span class="title">Dashboard</span>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="doc_profile.aspx" class="nav-link ">
                                            <span class="title">My Profile</span>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item  ">
                                <a href="#" class="nav-link nav-toggle">
                                    <i class="material-icons">assignment</i>
                                    <span class="title">Appointment</span><span class="arrow"></span>
                                </a>
                                <ul class="sub-menu">
                                    <li class="nav-item  ">
                                        <a href="doc_past_appoint.aspx" class="nav-link ">
                                            <span class="title">Past Appointments</span>
                                        </a>
                                    </li>
                                    <li class="nav-item  ">
                                        <a href="doc_new_appoint.aspx" class="nav-link ">
                                            <span class="title">Upcoming Appointments</span>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item  ">
                                <a href="#" class="nav-link nav-toggle">
                                    <i class="material-icons">group</i>
                                    <span class="title">Staff</span> <span class="arrow"></span>
                                </a>
                                <ul class="sub-menu">
                                    <li class="nav-item  ">
                                        <a href="doc_all_staffs.aspx" class="nav-link ">
                                            <span class="title">Staff Directory</span>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item  ">
                                <a href="#" class="nav-link nav-toggle">
                                    <i class="material-icons">accessible</i>
                                    <span class="title">Patients</span> <span class="arrow"></span>
                                </a>
                                <ul class="sub-menu">
                                    <li class="nav-item  ">
                                        <a href="doc_all_patients.aspx" class="nav-link ">
                                            <span class="title">My Patients</span>
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
                                <div class="page-title">My Profile</div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <!-- BEGIN PROFILE CONTENT -->
                            <div class="profile-content">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card ">
                                            <div class="card-body no-padding height-9">
                                                <div class="profile-usertitle">
                                                    <div class="profile-usertitle-name" id="name" runat="server">
                                                        Doc_Name_F Doc_Name_L </div>
                                                    <div class="profile-usertitle-job" id="specField" runat="server">
                                                        Doc_Specialization</div>
                                                </div>
                                                <ul class="list-group list-group-unbordered">
                                                    <li class="list-group-item">
                                                        <b>Gender</b> <span class="pull-right" id="gender"
                                                            runat="server">Doc_Gender</span>
                                                    </li>
                                                    <li class="list-group-item">
                                                        <b>DOB</b> <span class="pull-right" id="dob"
                                                            runat="server">Doc_DOB</span>
                                                    </li>
                                                    <li class="list-group-item">
                                                        <b>Email</b> <span class="pull-right" id="email"
                                                            runat="server">Doc_Email</span>
                                                    </li>
                                                    <li class="list-group-item">
                                                        <b>Primary Phone #</b> <span class="pull-right" id="phone"
                                                            runat="server">Doc_Phone</span>
                                                    </li>
                                                    <li class="list-group-item">
                                                        <b>Address 1</b> <span class="pull-right" id="street"
                                                            runat="server">Doc_Addr_Street</span>
                                                    </li>
                                                    <li class="list-group-item">
                                                        <b>Address 2</b> <span class="pull-right" id="street2"
                                                            runat="server">Doc_Addr_2</span>
                                                    </li>
                                                    <li class="list-group-item">
                                                        <b>City</b> <span class="pull-right" id="city"
                                                            runat="server">Doc_Addr_City</span>
                                                    </li>
                                                    <li class="list-group-item">
                                                        <b>State</b> <span class="pull-right" id="state"
                                                            runat="server">Doc_Addr_State</span>
                                                    </li>
                                                    <li class="list-group-item">
                                                        <b>Zip Code</b> <span class="pull-right" id="zip"
                                                            runat="server">Doc_Addr_Zip</span>
                                                    </li>
                                                </ul>
                                                <!-- END SIDEBAR USER TITLE -->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- END PROFILE CONTENT -->
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end page content -->
            </div>
            <!-- end page container -->
        </div>
    </div>
    <!-- start js include path -->
    <script src="plugins/jquery/jquery.min.js"></script>
    <script src="plugins/popper/popper.min.js"></script>
    <script src="plugins/jquery-blockui/jquery.blockui.min.js"></script>
    <script src="plugins/jquery-slimscroll/jquery.slimscroll.js"></script>
    <!-- bootstrap -->
    <script src="plugins/bootstrap/js/bootstrap.min.js"></script>
    <!-- counterup -->
    <script src="plugins/counterup/jquery.waypoints.min.js"></script>
    <script src="plugins/counterup/jquery.counterup.min.js"></script>
    <!-- Common js-->
    <script src="js/app.js"></script>
    <script src="js/layout.js"></script>
    <script src="js/theme-color.js"></script>
    <!-- material -->
    <script src="plugins/material/material.min.js"></script>
    <!-- chart js -->
    <script src="plugins/chart-js/Chart.bundle.js"></script>
    <script src="plugins/chart-js/utils.js"></script>
    <script src="js/pages/chart/chartjs/home-data2.js"></script>
    <script src="plugins/sparkline/jquery.sparkline.min.js"></script>
    <script src="js/pages/sparkline/sparkline-data.js"></script>
    <!-- end js include path -->
</body>

</html>