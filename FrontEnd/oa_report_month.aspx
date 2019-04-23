<%@ Page Language="C#" Debug="true" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Text.RegularExpressions" %>
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
    }
    void setupPage()
    {
        string User_EID = "-1";

        //Get user cookie data
        HttpCookie uInfo = Request.Cookies["uInfo"];
        if (uInfo != null)
        {
            //If successful, set up page data
            loadUserData(uInfo); //TODO: Ensure this loads on initial page load
            loadreportinfoTable();
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

        strSelect = "SELECT * FROM office_admin WHERE OA_ID = @EID";
        strConnect = "server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";

        SqlConnection myConnection = new SqlConnection(strConnect);
        myConnection.Open();
        SqlCommand myCommand = new SqlCommand(strSelect, myConnection);
        myCommand.Parameters.AddWithValue("@EID", uInfo["EID"].ToString());

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
    }
    void loadreportinfoTable()
    {
        //Loads components specific to appointment count
        string strSelect;
        string strforpat = "SELECT Pat_Name_F FROM patient";
        string strfordoc = "SELECT Doc_Name_F FROM doctor";
        string strforstaff = "SELECT OA_Name_F FROM office_admin";
        string strforappt = "SELECT Appt_ID FROM appointment";
        string strforappt_pat_id = "SELECT DISTINCT Appt_Pat_ID FROM appointment";
        string strforappt_appt_date = "SELECT DISTINCT Appt_Date, Appt_Pat_ID FROM appointment ";
        string strConnect;

        strSelect = "SELECT Pat_Name_F, Pat_Name_L, Doc_Name_F, Doc_Name_L, Doc_Specialization, App_ID, App_Given FROM approval, doctor, patient WHERE App_Pat_ID = Pat_ID AND App_Doc_ID = Doc_ID AND App_Given IS null";
        strConnect = "server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";

        SqlConnection myConnection = new SqlConnection(strConnect);
        myConnection.Open();
        SqlCommand myCommand = new SqlCommand(strSelect, myConnection);
        SqlCommand myCommand_pat = new SqlCommand(strforpat, myConnection);
        SqlCommand myCommand_doc = new SqlCommand(strfordoc, myConnection);
        SqlCommand myCommand_staff = new SqlCommand(strforstaff, myConnection);
        SqlCommand myCommand_appt = new SqlCommand(strforappt, myConnection);
        SqlCommand myCommand_appt_pat_id = new SqlCommand(strforappt_pat_id, myConnection);
        SqlCommand myCommand_appt_date = new SqlCommand(strforappt_appt_date, myConnection);


        SqlDataReader objDataReader, objDataReader_pat, objDataReader_doc, objDataReader_staff, objDataReader_appt, objDataReader_appt_pat_id, objDataReader_appt_date;






        //Build Specialist Appt Table
        string tableOut2 = "<table id='table' style='width:100%'>";
        tableOut2 += "<thead><tr><td class='font-weight-bold' style='width:25%'>New Patients</td><td class='font-weight-bold'>Returning Patients</td><td class='font-weight-bold'>Appointments</td><td class='font-weight-bold'>Prescriptions</td></tr></thead>";


        objDataReader_pat = myCommand_pat.ExecuteReader();
        int countforpatient = 0;
        int countfordoc = 0;
        int countforstaff = 0;
        int countforappt = 0;
        int countforappt_pat_id = 0;
        int countforappt_pat_id_month = 0;
        while (objDataReader_pat.Read())
        {
            // Use the row data, presumably
            countforpatient++;
        }
        objDataReader_pat.Close();
        objDataReader_doc = myCommand_doc.ExecuteReader();
        while (objDataReader_doc.Read())
        {
            // Use the row data, presumably
            countfordoc++;
        }
        objDataReader_doc.Close();
        objDataReader_staff = myCommand_staff.ExecuteReader();
        while (objDataReader_staff.Read())
        {
            // Use the row data, presumably
            countforstaff++;
        }
        countforstaff += countfordoc;
        objDataReader_staff.Close();
        objDataReader_appt = myCommand_appt.ExecuteReader();
        while (objDataReader_appt.Read())
        {
            // Use the row data, presumably
            countforappt++;
        }
        objDataReader_appt.Close();
        objDataReader_appt_pat_id = myCommand_appt_pat_id.ExecuteReader();
        ArrayList myList = new ArrayList();
        while (objDataReader_appt_pat_id.Read())
        {
            // Use the row data, presumably

            //myList.Add( objDataReader_appt_pat_id["Appt_Pat_ID"]);
            countforappt_pat_id++;
        }
        objDataReader_appt_pat_id.Close();
        objDataReader_appt_date = myCommand_appt_date.ExecuteReader();
        while (objDataReader_appt_date.Read())
        {
            // Use the row data, presumably
            //myList.Add(objDataReader_appt_date["Appt_Date"]);
            DateTime day = Convert.ToDateTime(objDataReader_appt_date["Appt_Date"]);
            if (day.Month == DateTime.Today.Month)


                myList.Add(objDataReader_appt_date["Appt_Pat_ID"]);


            //myList.Add( objDataReader_appt_pat_id["Appt_Pat_ID"]);

        }
        objDataReader_appt_date.Close();
         ArrayList myList2 =myList;
         for (int i = 0; i < myList2.Count; i++)
            {
                for (int j = i + 1; j < myList2.Count; j++)
                {
                    if (myList2[i].Equals(myList2[j]))
                    {
                        myList2.RemoveAt(j);
                        if (i > 0)
                        {
                            i--;
                        }
                    }
                }
            }


        objDataReader = myCommand.ExecuteReader();

        tableOut2 += "<tr class='odd gradeX'>";

        // tableOut += "<td>" + objDataReader["Appt_Date"].ToString() + "</td>";
        // tableOut += "<td>" + objDataReader["App_Office_ID"].ToString() + "</td>";
        // tableOut += "<td><a href=\"oa_edit_staff.aspx\" class=\"btn btn-tbl-edit btn-xs\"><i class=\"fa fa-pencil\"></i></a></td>";
        tableOut2 += "<td>" + myList2.Count + "<td>" + (myList.Count - myList2.Count) + "<td>" +myList.Count+ "<td>" + myList.Count;


        tableOut2 += "</table>";
        objDataReader.Close();
        reportinfoTable.InnerHtml = tableOut2;
    }
</script>

<body class="page-header-fixed sidemenu-closed-hidelogo page-content-white page-md header-white dark-color logo-dark">
    <div class="page-wrapper">
        <!-- start header -->
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
                                        <i class="fa fa-sign-out"></i>Log Out </a>
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
                                <div class="page-title">Reports</div>
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
                                                        <header>THIS MONTH</header>
                                                        <div class="tools">
                                                            <a class="fa fa-repeat btn-color box-refresh" href="javascript:;"></a>
                                                            <a class="t-collapse btn-color fa fa-chevron-down" href="javascript:;"></a>
                                                            <a class="t-close btn-color fa fa-times" href="javascript:;"></a>
                                                        </div>
                                                    </div>
                                                    <div class="card-body ">
                                                        <div class="table-scrollable" id="reportinfoTable" runat="server">
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
        <!-- start footer -->
        <div class="page-footer">
            <div class="scroll-to-top">
                <i class="material-icons">eject</i>
            </div>
        </div>
        <!-- end footer -->
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
