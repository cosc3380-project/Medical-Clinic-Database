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
    <link href="plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" type="text/css" />
    <!-- Material Design Lite CSS -->
    <link href="plugins/material/material.min.css" rel="stylesheet">
    <link href="css/material_style.css" rel="stylesheet">
    <!-- Theme Styles -->
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="css/plugins.min.css" rel="stylesheet" type="text/css" />
    <link href="css/pages/formlayout.css" rel="stylesheet" type="text/css" />
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
        string submit2 = Request.QueryString.Get("submit2");

        //Get user cookie data
        HttpCookie uInfo = Request.Cookies["uInfo"];
        if(uInfo != null)
        {
            //If successful, set up page data
            loadUserData(uInfo); //TODO: Ensure this loads on initial page load
            //displaySumbitButtonB();
        }
        else
        {
            //Silently note that an error occured
            namePlate.InnerHtml = "<p>" + User_EID + "</p><small>Admin</small>";
        }
        if(submit2 != null && submit2.Length > 0 && submit2 == "y")
        {
            //displaySubmitMsg(submit);
            //insertBloodTable();
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
    void displaySubmitMsgB(){
        String outMessage = "<font color=\"green\">Blood Test Results have been stored.</font>";
        submitMsgB.InnerHtml = outMessage;
    }
    void insertBloodTable(object sender, EventArgs e)
    {
        string strInsert;
        string strConnect;
        // string strSelect;

        // strSelect ="select * FROM blood_test WHERE BT_Appt_ID = @apptid AND Diag_Desc = @diagmsg";
        // strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";

        // SqlConnection myConnectionA = new SqlConnection(strConnect);
        // myConnectionA.Open();
        // SqlCommand myCommandA = new SqlCommand(strSelect, myConnectionA);
        // myCommandA.Parameters.AddWithValue( "@apptid", Request.QueryString.Get("apptid"));
        // myCommandA.Parameters.AddWithValue( "@diagmsg", desc.Text);

        // SqlDataReader objDataReader;
        // objDataReader = myCommandA.ExecuteReader();
        // if (objDataReader.Read()) //Prevent duplicate aproval records
        // {
        //     myConnectionA.Close();
        //     return;
        // }
        // myConnectionA.Close();
        // objDataReader.Close();

        strInsert ="INSERT INTO blood_test (BT_Appt_ID, BT_RBC, BT_WBC, BT_Platelet_Cnt, BT_Hgb, BT_Hct, BT_MCV, BT_Deleted) VALUES (@apptid, @rbc, @wbc, @pltcnt, @hgb, @hct, @mcv, 0)";

        strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";
        SqlConnection myConnection = new SqlConnection(strConnect);
        myConnection.Open();

        SqlCommand myCommand = new SqlCommand(strInsert, myConnection);
        myCommand.Parameters.AddWithValue( "@apptid", Request.QueryString.Get("apptid"));
        try
        {
            myCommand.Parameters.AddWithValue( "@rbc", Convert.ToDouble(rbc.Text));
            myCommand.Parameters.AddWithValue( "@wbc", Convert.ToDouble(wbc.Text));
            myCommand.Parameters.AddWithValue( "@pltcnt", Convert.ToDouble(pltcnt.Text));
            myCommand.Parameters.AddWithValue( "@hgb", Convert.ToDouble(hgb.Text));
            myCommand.Parameters.AddWithValue( "@hct", Convert.ToDouble(hct.Text));
            myCommand.Parameters.AddWithValue( "@mcv", Convert.ToDouble(mcv.Text));
            myCommand.ExecuteNonQuery();
            displaySubmitMsgB();
        
        }
        catch(Exception err)
        {
            subApptB.InnerHtml = "*Fireworks*<br><br>" + e.ToString();
        }
        
        
        myConnection.Close();
        }
    void displaySumbitButtonB(){
            string outMessage = "<a href='oa_add_blood_test.aspx?&submit2=y&apptid=" + Request.QueryString.Get("apptid") + "' class='btn btn-tbl btn-xs'/><i>Submit</i></a>";
            outMessage += "<a href='oa_current_appointment.aspx' class='btn btn-tbl btn-xs'/><i>Cancel</i></a>";
            subApptB.InnerHtml = outMessage;
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
                                <div class="page-title">Add Results</div>
                            </div>
                        </div>
                    </div>
                    <!-- start blood test -->
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="card card-box">
                                <div class="card-head">
                                    <header>Blood Test Results</header>
                                </div>
                                <div class="card-body" id="bar-parent">
                                    <form id="updateForm2" class="form-horizontal" runat="server">
                                        <div class="form-body">
                                            <!-- Blood Test -->
                                            <!-- RBCin mil cells/mcL, WBC in cells/mcL, Platelet count in thousand platelets/mcL,Hgb in gm/dL, Hct in %, MCV in fl/red cell -->
                                            <div class="form-group row">
                                                <label class="control-label col-md-3">
                                                    RBC
                                                    <span class="required"> * </span>
                                                </label>
                                                <div class="col-md-5">
                                                    <asp:TextBox runat="server" id="rbc" placeholder="RBC in mil cells/mcL" class="form-control input-height" maxlength="4"/>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="control-label col-md-3">
                                                    WBC
                                                    <span class="required"> * </span>
                                                </label>
                                                <div class="col-md-5">
                                                    <asp:TextBox runat="server" id="wbc" placeholder="WBC in cells/mcL" class="form-control input-height" maxlength="6"/>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="control-label col-md-3">
                                                    Platelet Count
                                                    <span class="required"> * </span>
                                                </label>
                                                <div class="col-md-5">
                                                    <asp:TextBox runat="server" id="pltcnt" placeholder="Platelet count in thousand platelets/mcL" class="form-control input-height" maxlength="4"/>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="control-label col-md-3">
                                                    Hemoglobin
                                                    <span class="required"> * </span>
                                                </label>
                                                <div class="col-md-5">
                                                    <asp:TextBox runat="server" id="hgb" placeholder="Hgb in gm/dL" class="form-control input-height" maxlength="4"/>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="control-label col-md-3">
                                                    Hematocrit
                                                    <span class="required"> * </span>
                                                </label>
                                                <div class="col-md-5">
                                                    <asp:TextBox runat="server" id="hct" placeholder="Hct in %" class="form-control input-height" maxlength="4"/>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="control-label col-md-3">
                                                    MCV
                                                    <span class="required"> * </span>
                                                </label>
                                                <div class="col-md-5">
                                                    <asp:TextBox runat="server" id="mcv" placeholder="MCV in fl/red cell" class="form-control input-height" maxlength="4"/>
                                                </div>
                                            </div>

                                            
                                            <div class="form-actions">
                                                <span id="resultOut2" runat="server"></span>
                                                <asp:ValidationSummary ID="ValidationSummary2" runat="server" HeaderText="Please check and correct these fields:" DisplayMode="List" />
                                                
                                                <asp:RequiredFieldValidator ID="rbcRequiredValidator" runat="server" ErrorMessage="RBC is required" ControlToValidate="rbc" Display="None"></asp:RequiredFieldValidator>
                                                <asp:RequiredFieldValidator ID="wbcRequiredValidator" runat="server" ErrorMessage="WBC is required" ControlToValidate="wbc" Display="None"></asp:RequiredFieldValidator>
                                                <asp:RequiredFieldValidator ID="pltcntRequiredValidator" runat="server" ErrorMessage="Platelet Count is required" ControlToValidate="pltcnt" Display="None"></asp:RequiredFieldValidator>
                                                <asp:RequiredFieldValidator ID="hgbRequiredValidator" runat="server" ErrorMessage="Hemoglobin is required" ControlToValidate="hgb" Display="None"></asp:RequiredFieldValidator>
                                                <asp:RequiredFieldValidator ID="hctRequiredValidator" runat="server" ErrorMessage="Hematocrit is required" ControlToValidate="hct" Display="None"></asp:RequiredFieldValidator>
                                                <asp:RequiredFieldValidator ID="mcvRequiredValidator" runat="server" ErrorMessage="MCV is required" ControlToValidate="mcv" Display="None"></asp:RequiredFieldValidator>
                                                
                                                <div class="row">
                                                    <div id="submitMsgB" runat="server"></div>
                                                    <div class="offset-md-3 col-md-9" id=subApptB runat="server">
                                                    </div>
                                                </div>
                                            </div>
                                            <div style="text-align:center">
                                                <asp:Button ID="submitButton" Text="Submit" OnClick="insertBloodTable" runat="server" class="btn btn-tbl btn-xs" UseSubmitBehavior="False" />
                                                <asp:Button ID="cancelButton" Text="Cancel" runat="server" PostBackUrl="oa_current_appointment.aspx" class="btn btn-tbl btn-xs" UseSubmitBehavior="False" />
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
        </div>
        <!-- end page container -->
        <!-- start footer -->

        <!-- end footer -->
    </div>
    <!-- start js include path -->
    <script src="plugins/jquery/jquery.min.js"></script>
    <script src="plugins/popper/popper.min.js"></script>
    <script src="plugins/jquery-blockui/jquery.blockui.min.js"></script>
    <script src="plugins/jquery-slimscroll/jquery.slimscroll.js"></script>
    <script src="plugins/jquery-validation/js/jquery.validate.min.js"></script>
    <script src="plugins/jquery-validation/js/additional-methods.min.js"></script>
    <!-- bootstrap -->
    <script src="plugins/bootstrap/js/bootstrap.min.js"></script>
    <script src="plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
    <script src="plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker-init.js"></script>
    <!-- Common js-->
    <script src="js/app.js"></script>
    <script src="js/pages/validation/form-validation.js"></script>
    <script src="js/layout.js"></script>
    <script src="js/theme-color.js"></script>
    <!-- Material -->
    <script src="plugins/material/material.min.js"></script>
    <!-- end js include path -->
</body>

</html>