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
    <!-- data tables -->
    <link href="plugins/datatables/plugins/bootstrap/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
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
        if(uInfo != null)
        {
            //If successful, set up page data
            loadUserData(uInfo); //TODO: Ensure this loads on initial page load
        }
        else
        {
            //Silently note that an error occured
            namePlate.InnerHtml = "<p>" + User_EID + "</p><small>Admin</small>";
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
    void loadStaffTable()
    {
        //Loads components specific to Office Admins
        string strSelectA;
        string strConnect;

        strSelectA ="SELECT OA_Role, OA_Name_F, OA_Name_L, OA_Email, OA_Phone, OA_Off_ID,  Off_Addr_Street, Off_Addr_2, Off_Addr_City, Off_Addr_State from office_admin, office WHERE Off_ID = OA_Off_ID";
        strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";

        SqlConnection myConnection = new SqlConnection(strConnect);
        myConnection.Open();
        SqlCommand myCommandA = new SqlCommand(strSelectA, myConnection);

        SqlDataReader objDataReader;
        objDataReader = myCommandA.ExecuteReader();

        //Build the OA part of the table
        string tableOut = "<table id='tableExport' style='width:100%'>";
        tableOut += "<thead><tr><td class='font-weight-bold' style='width:25%'>Name</td><td class='font-weight-bold'>Role</td><td class='font-weight-bold'>Office Location</td><td class='font-weight-bold'>Phone</td><td class='font-weight-bold'>Email</td></tr></thead>";
        while(objDataReader.Read())
        {
            tableOut += "<tr class='odd gradeX'>";
            tableOut += "<td>" + objDataReader["OA_Name_F"].ToString() + " " + objDataReader["OA_Name_L"].ToString() + "</td>";
            tableOut += "<td>" + objDataReader["OA_Role"].ToString() + "</td>";
            tableOut += "<td>" + objDataReader["Off_Addr_Street"].ToString() + " " + objDataReader["Off_Addr_2"].ToString() + " " + objDataReader["Off_Addr_City"].ToString() + " " +objDataReader["Off_Addr_State"].ToString() + "</td>";
            tableOut += "<td>" + objDataReader["OA_Phone"].ToString() + "</td>";
            tableOut += "<td>" + objDataReader["OA_Email"].ToString() + "</td>";
            // tableOut += "<td><a href=\"oa_edit_staff.aspx\" class=\"btn btn-tbl-edit btn-xs\"><i class=\"fa fa-pencil\"></i></a></td>";
            tableOut += "</tr>";
        }
        objDataReader.Close();
        
        //Loads components specific to doctors
        string strSelectB;
        strSelectB ="SELECT Doc_Name_F, Doc_Name_L, Doc_Email, Doc_Phone, Doc_Specialization from doctor";
        SqlCommand myCommandB = new SqlCommand(strSelectB, myConnection);
        objDataReader = myCommandB.ExecuteReader();

        //Continue to build table, using Doctor attributes
        while(objDataReader.Read())
        {
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
            <div class="page-header navbar navbar-fixed-top">
                <div class="page-header-inner ">
                    <!-- logo start -->
                    <div class="page-logo">
                        <a href="oa_ui.aspx">
                            <span class="logo-default">StarCare</span> </a>
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
                                            <i class="fa fa-sign-out"></i> Log Out </a>
                                    </li>
                                </ul>
                            </li>
                            <!-- end manage user dropdown -->

                        </ul>
                    </div>
                </div>
            </div>
            <!-- End Apps Dropdown -->
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
                                <a href="user_profile.aspx">
                                    <i class="fa fa-user"></i> Profile </a>
                            </li>
                            <li>
                                <a href="#">
                                    <i class="fa fa-cogs"></i> Settings
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <i class="fa fa-question-circle"></i> Help
                                </a>
                            </li>
                            <li class="divider"> </li>
                            <li>
                                <a href="lock_screen.aspx">
                                    <i class="fa fa-lock"></i> Lock
                                </a>
                            </li>
                            <li>
                                <a href="login.aspx">
                                    <i class="fa fa-sign-out"></i> Log Out </a>
                            </li>
                        </ul>
                    </li>
                    <!-- end manage user dropdown -->
                    <li class="dropdown dropdown-quick-sidebar-toggler">
                        <a id="headerSettingButton" class="mdl-button mdl-js-button mdl-button--icon pull-right" data-upgraded=",MaterialButton">
                            <i class="material-icons">settings</i>
                        </a>
                    </li>
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
                            <div class="page-title">All Staff</div>
                        </div>
                        <ol class="breadcrumb page-breadcrumb pull-right">
                            <li><i class="fa fa-home"></i>&nbsp;<a class="parent-item" href="index.html">Home</a>&nbsp;<i class="fa fa-angle-right"></i>
                            </li>
                            <li><a class="parent-item" href="">Other Staff</a>&nbsp;<i class="fa fa-angle-right"></i>
                            </li>
                            <li class="active">All Staff</li>
                        </ol>
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
                                                    <div class="table-scrollable" id="TableZone" runat="server">
                                                        <table class="table table-hover table-checkable order-column full-width" id="example4">
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="tab2">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="card card-box">
                                                <div class="card-body no-padding ">
                                                    <div class="doctor-profile">
                                                        <img src="img/user/user10.jpg" class="doctor-pic" alt="">
                                                        <div class="profile-usertitle">
                                                            <div class="doctor-name">Pooja Patel </div>
                                                            <div class="name-center"> Nurse </div>
                                                        </div>
                                                        <p>A-103, shyam gokul flats, Mahatma Road <br />Mumbai</p>
                                                        <div>
                                                            <p><i class="fa fa-phone"></i><a href="tel:(123)456-7890"> (123)456-7890</a></p>
                                                        </div>
                                                        <div class="profile-userbuttons">
                                                            <a href="oa_staff_profile.aspx" class="btn btn-circle deepPink-bgcolor btn-sm">Read More</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="card card-box">
                                                <div class="card-body no-padding ">
                                                    <div class="doctor-profile">
                                                        <img src="img/user/user1.jpg" class="doctor-pic" alt="">
                                                        <div class="profile-usertitle">
                                                            <div class="doctor-name">Rajesh </div>
                                                            <div class="name-center"> Compounder </div>
                                                        </div>
                                                        <p>45, Krishna Tower, Near Bus Stop, Satellite, <br />Mumbai</p>
                                                        <div>
                                                            <p><i class="fa fa-phone"></i><a href="tel:(123)456-7890"> (123)456-7890</a></p>
                                                        </div>
                                                        <div class="profile-userbuttons">
                                                            <a href="oa_staff_profile.aspx" class="btn btn-circle deepPink-bgcolor btn-sm">Read More</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="card card-box">
                                                <div class="card-body no-padding ">
                                                    <div class="doctor-profile">
                                                        <img src="img/user/user2.jpg" class="doctor-pic" alt="">
                                                        <div class="profile-usertitle">
                                                            <div class="doctor-name">Sarah Smith </div>
                                                            <div class="name-center"> Nurse </div>
                                                        </div>
                                                        <p>456, Estern evenue, Courtage area, <br />New York</p>
                                                        <div>
                                                            <p><i class="fa fa-phone"></i><a href="tel:(123)456-7890"> (123)456-7890</a></p>
                                                        </div>
                                                        <div class="profile-userbuttons">
                                                            <a href="oa_staff_profile.aspx" class="btn btn-circle deepPink-bgcolor btn-sm">Read More</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="card card-box">
                                                <div class="card-body no-padding ">
                                                    <div class="doctor-profile">
                                                        <img src="img/user/user3.jpg" class="doctor-pic" alt="">
                                                        <div class="profile-usertitle">
                                                            <div class="doctor-name">John Deo </div>
                                                            <div class="name-center"> Supervisor </div>
                                                        </div>
                                                        <p>A-103, shyam gokul flats, Mahatma Road <br />Mumbai</p>
                                                        <div>
                                                            <p><i class="fa fa-phone"></i><a href="tel:(123)456-7890"> (123)456-7890</a></p>
                                                        </div>
                                                        <div class="profile-userbuttons">
                                                            <a href="oa_staff_profile.aspx" class="btn btn-circle deepPink-bgcolor btn-sm">Read More</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="card card-box">
                                                <div class="card-body no-padding ">
                                                    <div class="doctor-profile">
                                                        <img src="img/user/user4.jpg" class="doctor-pic" alt="">
                                                        <div class="profile-usertitle">
                                                            <div class="doctor-name">Jay Soni </div>
                                                            <div class="name-center"> Purchase Officer </div>
                                                        </div>
                                                        <p>45, Krishna Tower, Near Bus Stop, Satellite, <br />Mumbai</p>
                                                        <div>
                                                            <p><i class="fa fa-phone"></i><a href="tel:(123)456-7890"> (123)456-7890</a></p>
                                                        </div>
                                                        <div class="profile-userbuttons">
                                                            <a href="oa_staff_profile.aspx" class="btn btn-circle deepPink-bgcolor btn-sm">Read More</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="card card-box">
                                                <div class="card-body no-padding ">
                                                    <div class="doctor-profile">
                                                        <img src="img/user/user5.jpg" class="doctor-pic" alt="">
                                                        <div class="profile-usertitle">
                                                            <div class="doctor-name">Jacob Ryan </div>
                                                            <div class="name-center"> Receptionist </div>
                                                        </div>
                                                        <p>456, Estern evenue, Courtage area, <br />New York</p>
                                                        <div>
                                                            <p><i class="fa fa-phone"></i><a href="tel:(123)456-7890"> (123)456-7890</a></p>
                                                        </div>
                                                        <div class="profile-userbuttons">
                                                            <a href="oa_staff_profile.aspx" class="btn btn-circle deepPink-bgcolor btn-sm">Read More</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="card card-box">
                                                <div class="card-body no-padding ">
                                                    <div class="doctor-profile">
                                                        <img src="img/user/user6.jpg" class="doctor-pic" alt="">
                                                        <div class="profile-usertitle">
                                                            <div class="doctor-name">Megha Trivedi </div>
                                                            <div class="name-center">Nurse </div>
                                                        </div>
                                                        <p>A-103, shyam gokul flats, Mahatma Road <br />Mumbai</p>
                                                        <div>
                                                            <p><i class="fa fa-phone"></i><a href="tel:(123)456-7890"> (123)456-7890</a></p>
                                                        </div>
                                                        <div class="profile-userbuttons">
                                                            <a href="oa_staff_profile.aspx" class="btn btn-circle deepPink-bgcolor btn-sm">Read More</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="card card-box">
                                                <div class="card-body no-padding ">
                                                    <div class="doctor-profile">
                                                        <img src="img/user/user1.jpg" class="doctor-pic" alt="">
                                                        <div class="profile-usertitle">
                                                            <div class="doctor-name">Rajesh </div>
                                                            <div class="name-center"> Lab Assistent </div>
                                                        </div>
                                                        <p>45, Krishna Tower, Near Bus Stop, Satellite, <br />Mumbai</p>
                                                        <div>
                                                            <p><i class="fa fa-phone"></i><a href="tel:(123)456-7890"> (123)456-7890</a></p>
                                                        </div>
                                                        <div class="profile-userbuttons">
                                                            <a href="oa_staff_profile.aspx" class="btn btn-circle deepPink-bgcolor btn-sm">Read More</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="card card-box">
                                                <div class="card-body no-padding ">
                                                    <div class="doctor-profile">
                                                        <img src="img/user/user2.jpg" class="doctor-pic" alt="">
                                                        <div class="profile-usertitle">
                                                            <div class="doctor-name">Sarah Smith </div>
                                                            <div class="name-center"> Nurse </div>
                                                        </div>
                                                        <p>456, Estern evenue, Courtage area, <br />New York</p>
                                                        <div>
                                                            <p><i class="fa fa-phone"></i><a href="tel:(123)456-7890"> (123)456-7890</a></p>
                                                        </div>
                                                        <div class="profile-userbuttons">
                                                            <a href="oa_staff_profile.aspx" class="btn btn-circle deepPink-bgcolor btn-sm">Read More</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="card card-box">
                                                <div class="card-body no-padding ">
                                                    <div class="doctor-profile">
                                                        <img src="img/user/user10.jpg" class="doctor-pic" alt="">
                                                        <div class="profile-usertitle">
                                                            <div class="doctor-name">Pooja Patel </div>
                                                            <div class="name-center"> Pharmacist </div>
                                                        </div>
                                                        <p>A-103, shyam gokul flats, Mahatma Road <br />Mumbai</p>
                                                        <div>
                                                            <p><i class="fa fa-phone"></i><a href="tel:(123)456-7890"> (123)456-7890</a></p>
                                                        </div>
                                                        <div class="profile-userbuttons">
                                                            <a href="oa_staff_profile.aspx" class="btn btn-circle deepPink-bgcolor btn-sm">Read More</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="card card-box">
                                                <div class="card-body no-padding ">
                                                    <div class="doctor-profile">
                                                        <img src="img/user/user1.jpg" class="doctor-pic" alt="">
                                                        <div class="profile-usertitle">
                                                            <div class="doctor-name">Rajesh </div>
                                                            <div class="name-center"> Compounder </div>
                                                        </div>
                                                        <p>45, Krishna Tower, Near Bus Stop, Satellite, <br />Mumbai</p>
                                                        <div>
                                                            <p><i class="fa fa-phone"></i><a href="tel:(123)456-7890"> (123)456-7890</a></p>
                                                        </div>
                                                        <div class="profile-userbuttons">
                                                            <a href="staff_profile.aspx" class="btn btn-circle deepPink-bgcolor btn-sm">Read More</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="card card-box">
                                                <div class="card-body no-padding ">
                                                    <div class="doctor-profile">
                                                        <img src="img/user/user3.jpg" class="doctor-pic" alt="">
                                                        <div class="profile-usertitle">
                                                            <div class="doctor-name">John Deo </div>
                                                            <div class="name-center"> Supervisor </div>
                                                        </div>
                                                        <p>A-103, shyam gokul flats, Mahatma Road <br />Mumbai</p>
                                                        <div>
                                                            <p><i class="fa fa-phone"></i><a href="tel:(123)456-7890"> (123)456-7890</a></p>
                                                        </div>
                                                        <div class="profile-userbuttons">
                                                            <a href="oa_staff_profile.aspx" class="btn btn-circle deepPink-bgcolor btn-sm">Read More</a>
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
        </div>
        <!-- end page content -->
        <!-- start chat sidebar -->
        <div class="chat-sidebar-container" data-close-on-body-click="true">
            <div class="chat-sidebar">
                <ul class="nav nav-tabs">
                    <li class="nav-item">
                        <a href="#quick_sidebar_tab_1" class="nav-link active tab-icon" data-toggle="tab">Theme</a>
                    </li>
                    <li class="nav-item">
                        <a href="#quick_sidebar_tab_2" class="nav-link tab-icon" data-toggle="tab">Settings</a>
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
                            <div class="chat-header">
                                <h5 class="list-heading">Layout Settings</h5>
                            </div>
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
                                <div class="chat-header">
                                    <h5 class="list-heading">Account Settings</h5>
                                </div>
                                <div class="settings-list">
                                    <div class="setting-item">
                                        <div class="setting-text">Notifications</div>
                                        <div class="setting-set">
                                            <div class="switch">
                                                <label class="mdl-switch mdl-js-switch mdl-js-ripple-effect" for="switch-1">
                                                    <input type="checkbox" id="switch-1" class="mdl-switch__input" checked>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="setting-item">
                                        <div class="setting-text">Show Online</div>
                                        <div class="setting-set">
                                            <div class="switch">
                                                <label class="mdl-switch mdl-js-switch mdl-js-ripple-effect" for="switch-7">
                                                    <input type="checkbox" id="switch-7" class="mdl-switch__input" checked>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="setting-item">
                                        <div class="setting-text">Status</div>
                                        <div class="setting-set">
                                            <div class="switch">
                                                <label class="mdl-switch mdl-js-switch mdl-js-ripple-effect" for="switch-2">
                                                    <input type="checkbox" id="switch-2" class="mdl-switch__input" checked>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="setting-item">
                                        <div class="setting-text">2 Steps Verification</div>
                                        <div class="setting-set">
                                            <div class="switch">
                                                <label class="mdl-switch mdl-js-switch mdl-js-ripple-effect" for="switch-3">
                                                    <input type="checkbox" id="switch-3" class="mdl-switch__input" checked>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="chat-header">
                                    <h5 class="list-heading">General Settings</h5>
                                </div>
                                <div class="settings-list">
                                    <div class="setting-item">
                                        <div class="setting-text">Location</div>
                                        <div class="setting-set">
                                            <div class="switch">
                                                <label class="mdl-switch mdl-js-switch mdl-js-ripple-effect" for="switch-4">
                                                    <input type="checkbox" id="switch-4" class="mdl-switch__input" checked>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="setting-item">
                                        <div class="setting-text">Save Histry</div>
                                        <div class="setting-set">
                                            <div class="switch">
                                                <label class="mdl-switch mdl-js-switch mdl-js-ripple-effect" for="switch-5">
                                                    <input type="checkbox" id="switch-5" class="mdl-switch__input" checked>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="setting-item">
                                        <div class="setting-text">Auto Updates</div>
                                        <div class="setting-set">
                                            <div class="switch">
                                                <label class="mdl-switch mdl-js-switch mdl-js-ripple-effect" for="switch-6">
                                                    <input type="checkbox" id="switch-6" class="mdl-switch__input" checked>
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
        <div class="scroll-to-top">
            <i class="material-icons">eject</i>
        </div>
    </div>
    <!-- end footer -->
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