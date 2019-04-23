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
        loadStaffTable();
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

            //Set page placeholders
            namePlate.InnerHtml = "<p>" + fName + " " + lName + "</p><small>" + spec + "</small>";
        }
        objDataReader.Close();
        myConnection.Close();
    }
    void loadStaffTable()
    {
        //Loads components specific to Office Admins
        string strSelectA;
        string strConnect;

        strSelectA = "SELECT OA_Role, OA_Name_F, OA_Name_L, OA_Email, OA_Phone, OA_Off_ID,  Off_Addr_Street, Off_Addr_2, Off_Addr_City, Off_Addr_State from office_admin, office WHERE Off_ID = OA_Off_ID";
        strConnect = "server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";

        SqlConnection myConnection = new SqlConnection(strConnect);
        myConnection.Open();
        SqlCommand myCommandA = new SqlCommand(strSelectA, myConnection);

        SqlDataReader objDataReader;
        objDataReader = myCommandA.ExecuteReader();

        //Build the OA part of the table
        string tableOut = "<table id='tableExport' class='table table-hover table-checkable order-column full-width' style='width:100%'>";
        tableOut += "<thead><tr><td class='font-weight-bold' style='width:25%'>Name</td><td class='font-weight-bold'>Role</td><td class='font-weight-bold'>Office Location</td><td class='font-weight-bold'>Phone</td><td class='font-weight-bold'>Email</td></tr></thead>";
        while (objDataReader.Read()) {
            tableOut += "<tr class='odd gradeX'>";
            tableOut += "<td>" + objDataReader["OA_Name_F"].ToString() + " " + objDataReader["OA_Name_L"].ToString() + "</td>";
            tableOut += "<td>" + objDataReader["OA_Role"].ToString() + "</td>";
            tableOut += "<td>" + objDataReader["Off_Addr_Street"].ToString() + " " + objDataReader["Off_Addr_2"].ToString() + " " + objDataReader["Off_Addr_City"].ToString() + " " + objDataReader["Off_Addr_State"].ToString() + "</td>";
            tableOut += "<td>" + objDataReader["OA_Phone"].ToString() + "</td>";
            tableOut += "<td>" + objDataReader["OA_Email"].ToString() + "</td>";
            // tableOut += "<td><a href=\"oa_edit_staff.aspx\" class=\"btn btn-tbl-edit btn-xs\"><i class=\"fa fa-pencil\"></i></a></td>";
            tableOut += "</tr>";
        }
        objDataReader.Close();

        //Loads components specific to doctors
        string strSelectB;
        strSelectB = "SELECT Doc_Name_F, Doc_Name_L, Doc_Email, Doc_Phone, Doc_Specialization from doctor";
        SqlCommand myCommandB = new SqlCommand(strSelectB, myConnection);
        objDataReader = myCommandB.ExecuteReader();

        //Continue to build table, using Doctor attributes
        while (objDataReader.Read()) {
            tableOut += "<tr class='odd gradeX'>";
            tableOut += "<td>" + objDataReader["Doc_Name_F"].ToString() + " " + objDataReader["Doc_Name_L"].ToString() + "</td>";
            tableOut += "<td>" + objDataReader["Doc_Specialization"].ToString() + "</td>";
            tableOut += "<td>" + "*Depending on Schedule*" + "</td>";
            tableOut += "<td>" + objDataReader["Doc_Phone"].ToString() + "</td>";
            tableOut += "<td>" + objDataReader["Doc_Email"].ToString() + "</td>";
            // tableOut += "<td><a href=\"oa_edit_staff.aspx\" class=\"btn btn-tbl-edit btn-xs\"><i class=\"fa fa-pencil\"></i></a></td>";
            tableOut += "</tr>";
        }
        tableOut += "</table>";

        //Set page placeholders
        TableZone.InnerHtml = tableOut;
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
                        <span class="logo-default">StarCare</span>
                    </a>
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
                                <div class="page-title">Staff Directory</div>
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
                                                    <div class="card-body ">
                                                        <div class="table-scrollable" id="TableZone" runat="server">

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