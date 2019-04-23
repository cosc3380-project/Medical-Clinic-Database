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
        loadDoctorData();
        checkPermission();
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
        }
        objDataReader.Close();
        myConnection.Close();
    }
    void loadDoctorData()
    {
        //Loads components specific to doctor's name :D
        string strSelect;
        string strConnect;
        string docName = "";

        strSelect ="SELECT Doc_Name_F, Doc_Name_L FROM doctor d WHERE d.Doc_ID = @docid AND Doc_Deleted <> 1";
        strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";

        SqlConnection myConnection = new SqlConnection(strConnect);
        myConnection.Open();
        SqlCommand myCommand = new SqlCommand(strSelect, myConnection);
        myCommand.Parameters.AddWithValue( "@docid", Request.Params.Get("docid").ToString());

        SqlDataReader objDataReader;
        objDataReader = myCommand.ExecuteReader();

        //Build the appointment table

        if(objDataReader.Read())
        {
            docName = objDataReader["Doc_Name_F"].ToString() + " " + objDataReader["Doc_Name_L"].ToString();
        }

        //Set page placeholders
        docLabel.InnerHtml = docName;
        objDataReader.Close();
        myConnection.Close();
    }
    void checkPermission()
    {
        string strConnect;
        string strSelect;

        strSelect ="select * FROM doctor WHERE Doc_ID = @docid";
        strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";

        SqlConnection myConnection = new SqlConnection(strConnect);
        myConnection.Open();
        SqlCommand myCommandA = new SqlCommand(strSelect, myConnection);
        myCommandA.Parameters.AddWithValue( "@docid", Request.Params.Get("docid").ToString());

        SqlDataReader objDataReader;
        objDataReader = myCommandA.ExecuteReader();
        if (objDataReader.Read())//Ensure doctor exists
        {
            if(objDataReader["Doc_Specialization"].ToString().Equals("General Doctor"))
            {
                buildCalendar();
                if(Array.IndexOf(Request.Params.AllKeys,"year") != -1)
                {
                    setTimes();
                }
            }
            else
            {
                objDataReader.Close();

                HttpCookie uInfo = Request.Cookies["uInfo"];

                strSelect ="select * FROM approval a, doctor d WHERE a.App_Pat_ID = @patid AND a.App_Doc_ID = @docid AND a.App_Doc_ID = d.Doc_ID";

                SqlCommand myCommandB = new SqlCommand(strSelect, myConnection);
                myCommandB.Parameters.AddWithValue( "@patid", uInfo["EID"].ToString());
                myCommandB.Parameters.AddWithValue( "@docid", Request.Params.Get("docid").ToString());

                objDataReader = myCommandB.ExecuteReader();
                if (objDataReader.Read())//Check to see if an approval record exists
                {
                    if(objDataReader["App_Given"].ToString().Equals("True")) //If approved
                    {
                        buildCalendar();
                        if(Array.IndexOf(Request.Params.AllKeys,"year") != -1)
                        {
                            setTimes();
                        }
                    }
                    else if(objDataReader["App_Given"].ToString().Equals("False")) //If denied
                    {
                        cardBody.Visible = false;
                        String reply;
                        reply = "Your request to see this doctor has been denied before. You may try again if desired.";
                        requestTag.InnerHtml = reply;

                        requestDiv.Visible = true;
                    }
                    else if(objDataReader["App_Given"].ToString().Length < 1) //If Pending
                    {
                        cardBody.Visible = false;
                        String reply;

                        reply = "Your request to see this doctor is pending. Please wait and try again later.";
                        requestTag.InnerHtml = reply;

                        requestButton.Visible = false;
                        requestDiv.Visible = true;
                    }
                }
                else
                {
                    cardBody.Visible = false;
                    String reply;
                    reply = "You'll need to file a request to see this doctor.";
                    requestTag.InnerHtml = reply;

                    requestDiv.Visible = true;
                }
            }
        }
        else
        {
            cardBody.Visible = false;
            requestTag.InnerHtml = "There was an error loading this doctor's availability. Please try again.</center>";
            requestButton.Visible = false;
            requestDiv.Visible = true;
        }



        myConnection.Close();
        objDataReader.Close();
    }
    void requestAppt(object sender, EventArgs e)
    {
        string strInsert;
        string strConnect;
        string strSelect;
        String reply;
        HttpCookie uInfo = Request.Cookies["uInfo"];

        strSelect ="select * FROM approval WHERE App_Pat_ID = @patid AND App_Doc_ID = @docid AND App_Spec_ID = 1";
        strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";

        SqlConnection myConnectionA = new SqlConnection(strConnect);
        myConnectionA.Open();
        SqlCommand myCommandA = new SqlCommand(strSelect, myConnectionA);
        myCommandA.Parameters.AddWithValue( "@patid", uInfo["EID"].ToString());
        myCommandA.Parameters.AddWithValue( "@docid", Request.Params.Get("docid").ToString());

        SqlDataReader objDataReader;
        objDataReader = myCommandA.ExecuteReader();
        if (objDataReader.Read()) //Prevent duplicate aproval records
        {
            cardBody.Visible = false;
            reply = "Request sent!";
            requestTag.InnerHtml = reply;

            requestButton.Visible = false;
            requestDiv.Visible = true;
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
        myCommand.Parameters.AddWithValue( "@patid", uInfo["EID"].ToString());
        myCommand.Parameters.AddWithValue( "@docid", Request.Params.Get("docid").ToString());

        myCommand.ExecuteNonQuery();
        myConnection.Close();

        reply = "<center>Request sent!";
        reply += "<br><br><a href='pat_select_doctor.aspx'><input id='returnButton' type='button' value='Return'/></a></center>";
        cardBody.InnerHtml = reply;
    }
    string checkAvailability(string strSelect)
    {
        string strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";

        SqlConnection myConnection = new SqlConnection(strConnect);
        myConnection.Open();
        SqlCommand myCommand = new SqlCommand(strSelect, myConnection);
        myCommand.Parameters.AddWithValue( "@docid", Request.Params.Get("docid").ToString());

        SqlDataReader objDataReader;
        objDataReader = myCommand.ExecuteReader();

        //If the doctor works at an office on this day
        if(objDataReader.Read())
        {
            //Assemble & return the office's address
            string returnStr = objDataReader["Off_Addr_Street"].ToString() + " " +
                objDataReader["Off_Addr_2"].ToString() + ", " +
                objDataReader["Off_Addr_City"].ToString() + ", " +
                objDataReader["Off_Addr_State"].ToString() + " " +
                objDataReader["Off_Addr_Zip"].ToString();
            objDataReader.Close();
            myConnection.Close();
            return returnStr;
        }
        else
        {
            //Return an empty string
            string returnStr = "";
            objDataReader.Close();
            myConnection.Close();
            return returnStr;
        }
    }
    void buildCalendar()
    {
        string schedText = "Doctor's Schedule:<br>";
        string[] offLocations = new string[7];
        string strSelect;


        //Get the doctor's availability for the week
        strSelect ="SELECT Off_Addr_Street, Off_Addr_2, Off_Addr_City, Off_Addr_State, Off_Addr_Zip FROM office WHERE Off_Doc_Sun = @docid AND Off_Deleted <> 1";
        offLocations[0] = checkAvailability(strSelect);

        strSelect ="SELECT Off_Addr_Street, Off_Addr_2, Off_Addr_City, Off_Addr_State, Off_Addr_Zip FROM office WHERE Off_Doc_Mon = @docid AND Off_Deleted <> 1";
        offLocations[1] = checkAvailability(strSelect);

        strSelect ="SELECT Off_Addr_Street, Off_Addr_2, Off_Addr_City, Off_Addr_State, Off_Addr_Zip FROM office WHERE Off_Doc_Tue = @docid AND Off_Deleted <> 1";
        offLocations[2] = checkAvailability(strSelect);

        strSelect ="SELECT Off_Addr_Street, Off_Addr_2, Off_Addr_City, Off_Addr_State, Off_Addr_Zip FROM office WHERE Off_Doc_Wed = @docid AND Off_Deleted <> 1";
        offLocations[3] = checkAvailability(strSelect);

        strSelect ="SELECT Off_Addr_Street, Off_Addr_2, Off_Addr_City, Off_Addr_State, Off_Addr_Zip FROM office WHERE Off_Doc_Thu = @docid AND Off_Deleted <> 1";
        offLocations[4] = checkAvailability(strSelect);

        strSelect ="SELECT Off_Addr_Street, Off_Addr_2, Off_Addr_City, Off_Addr_State, Off_Addr_Zip FROM office WHERE Off_Doc_Fri = @docid AND Off_Deleted <> 1";
        offLocations[5] = checkAvailability(strSelect);

        strSelect ="SELECT Off_Addr_Street, Off_Addr_2, Off_Addr_City, Off_Addr_State, Off_Addr_Zip FROM office WHERE Off_Doc_Sat = @docid AND Off_Deleted <> 1";
        offLocations[6] = checkAvailability(strSelect);



        //
        // *** given arrays
        //

        String[] mname = new string[] { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" };
        String[] dname = new string[] { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };

        //
        // *** get user data
        //

        int y = DateTime.Today.Year;
        int m = DateTime.Today.Month;

        //
        // ***set month and year
        //

        DateTime new_date = new DateTime(y,m,1);

        //
        // *** gat first day (0=SUN thru 6=SAT)
        //

        int first_day = Array.IndexOf(dname, new_date.DayOfWeek.ToString());

        //
        // *** get number of days for the specified month and year
        //

        int numdays = (new DateTime(y, m+1, 1) - new_date).Days;

        int cell_loc = 1; // *** start cell counter
        int day_out = 1;  // *** start day counter

        string os="<table border='1'>";
        os=os+"<tr><td colspan='7'><center><b>";
        os=os+mname[m - 1]+" "+y+"</b></center></td></tr><tr>";  // *** output month name and year
        for (int i=0; i<7; i++)
            os=os+"<td style='width:200px'><center><b>"+dname[i]+"</b></center></td>"; // *** output day name headings
        os=os+"</tr>";
        for (int r=2; r<9 ; r++)   // *** row loops for 2 to 8
        {
            if (day_out <= numdays ) // *** check and determine if there are day numbers yet to display
            {
                os=os+"<tr>";
                for (int c=0; c<7; c++) // *** column loop
                {
                    if (offLocations[c].Length == 0 || (day_out < numdays && new DateTime(y,m,day_out) < DateTime.Now)) //If the doctor is at an office today, create a white cell with a selectable option
                    {
                        if (cell_loc > first_day && day_out <= numdays)  // *** we are past the first day and NOT past the number of days
                        {
                            os=os+"<td style='background:#777777'><center>"+day_out.ToString()+"</center></td>";
                            day_out++; // *** count the days
                        }
                        else
                            os=os+"<td>&nbsp;</td>" ;
                        cell_loc++; // *** count the cells
                    }
                    else
                    {
                        if (cell_loc > first_day && day_out <= numdays)  // *** we are past the first day and NOT past the number of days
                        {
                            os=os+"<td><center><a href = 'pat_book_appointment.aspx?&docid=" + Request.Params.Get("docid").ToString() +
                                "&year=" + y +
                                "&month=" + (m - 1) +
                                "&day=" + day_out.ToString() +
                                "'>" + day_out.ToString() + "</a></center></td>";
                            day_out++; // *** count the days
                        }
                        else
                            os=os+"<td>&nbsp;</td>" ;
                        cell_loc++; // *** count the cells
                    }
                }
                os=os+"</tr>";
            }
        }
        //
        // *** only end of table is required below
        //
        os=os+"</table>";
        calendarOut.InnerHtml = os;

        //Output the doctor's schedule in text form as well
        for (int c=0; c<7; c++) // *** column loop
        {
            if (offLocations[c].Length != 0)
            {
                schedText += dname[c] + ": " + offLocations[c] + "<br>";
            }
        }
        scheduleOut.InnerHtml = schedText;
    }
    void setTimes()
    {
        int y = Convert.ToInt32(Request.Params.Get("year").ToString());
        int m = Convert.ToInt32(Request.Params.Get("month").ToString());
        int d = Convert.ToInt32(Request.Params.Get("day").ToString());

        DateTime schedDateMin = new DateTime(y, m+1, d, 8, 0, 0); //Because we had to remove 1 from month in buildCalendar
        DateTime schedDateMax = new DateTime(y, m+1, d, 16, 30, 0);
        DateTime currentTime = new DateTime(y, m+1, d, 8, 0, 0);

        //Loads components specific to appointments within the appropriate timeframe on the selected day
        string strSelect;
        string strConnect;

        strConnect ="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";
        SqlConnection myConnection = new SqlConnection(strConnect);


        strSelect ="SELECT count(Appt_Date) as cnt FROM appointment WHERE (Appt_Date BETWEEN @start AND @end) AND Appt_Deleted <> 1";
        myConnection.Open();
        SqlCommand myCommandA = new SqlCommand(strSelect, myConnection);
        myCommandA.Parameters.AddWithValue( "@start", schedDateMin);
        myCommandA.Parameters.AddWithValue( "@end", schedDateMax);

        SqlDataReader objDataReader;
        objDataReader = myCommandA.ExecuteReader();

        if(objDataReader.Read())
        {
            if(Convert.ToInt32(objDataReader["cnt"]) > 0)
            {
                DateTime[] timesBooked = new DateTime[Convert.ToInt32(objDataReader["cnt"])];
                bool found = false;
                int c = 0;

                objDataReader.Close();

                strSelect ="SELECT Appt_Date FROM appointment WHERE (Appt_Date BETWEEN @start AND @end) AND Appt_Deleted <> 1";

                SqlCommand myCommandB = new SqlCommand(strSelect, myConnection);
                myCommandB.Parameters.AddWithValue( "@start", schedDateMin);
                myCommandB.Parameters.AddWithValue( "@end", schedDateMax);

                objDataReader = myCommandB.ExecuteReader();

                while (objDataReader.Read())
                {
                    timesBooked[c] = Convert.ToDateTime(objDataReader["Appt_Date"]);
                    c += 1;
                }

                while(currentTime <= schedDateMax)
                {
                    found = false;
                    for (int i = 0; i < c; i += 1)
                    {
                        if (timesBooked[i] == currentTime)
                        {
                            found = true;
                            break;
                        }
                    }

                    if(!found)
                    {
                        addToList(currentTime);
                    }

                    currentTime = currentTime.AddMinutes(30);
                }
            }
            else
            {
                while(currentTime <= schedDateMax)
                {
                    addToList(currentTime);

                    currentTime = currentTime.AddMinutes(30);
                }
            }
        }
        objDataReader.Close();
        myConnection.Close();
    }
    void addToList(DateTime currentTime)
    {
        string hour, am_pm;
        string min = currentTime.Minute.ToString().PadLeft(2,'0');

        if (currentTime.Hour < 12)
        {
            hour = currentTime.Hour.ToString().PadLeft(2,'0');
            am_pm = "AM";
        }
        else if (currentTime.Hour == 12)
        {
            hour = currentTime.Hour.ToString().PadLeft(2,'0');
            am_pm = "PM";
        }
        else
        {
            hour = (currentTime.Hour - 12).ToString().PadLeft(2,'0');
            am_pm = "PM";
        }
        if(!timePicker.Items.Contains(new ListItem(hour + ":" + min + " " + am_pm, currentTime.ToBinary().ToString())))
            timePicker.Items.Add(new ListItem(hour + ":" + min + " " + am_pm, currentTime.ToBinary().ToString()));
    }
    void validate(object sender, EventArgs e)
    {
        HttpCookie uInfo = Request.Cookies["uInfo"];

        //Check for valid input
        if (timePicker.Items.Count == 0)
        {
            resultOut.InnerHtml = "Please select a date for your appointment.";
            return;
        }
        if(timePicker.SelectedValue.Length == 0)
        {
            resultOut.InnerHtml = "Please select a time for your appointment.<br>If no times are available for the date you selected, please choose a different date.";
            return;
        }
        if(reason.Text.Length == 0)
        {
            resultOut.InnerHtml = "Please enter a reason for your visit.";
            return;
        }
        else
        {
            resultOut.InnerHtml = "Adding row to table... (" + timePicker.SelectedItem.Value + ")";
        }

        //If all valid input, add row to appointment database and proceed
        int numa = 0;
        string dateString = timePicker.SelectedItem.Value;
        DateTime selectedDate = DateTime.FromBinary(Convert.ToInt64(dateString));

        //selectedDate = selectedDate.AddMonths(1); //Because we had to remove 1 from month in buildCalendar

        string strInsert ="INSERT into appointment (Appt_Doc_ID, Appt_Pat_ID, Appt_Office_ID, Appt_Date, Appt_Deleted) " +
                "VALUES (@docID, @patID, @offID, @date, 0)";
        string strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";
        SqlConnection myConnection = new SqlConnection(strConnect);
        SqlCommand myCommand = new SqlCommand(strInsert, myConnection);

        myCommand.Parameters.AddWithValue( "@docID", Request.Params.Get("docid").ToString() );
        myCommand.Parameters.AddWithValue( "@patID",  uInfo["EID"].ToString());
        myCommand.Parameters.AddWithValue( "@offID", "1" );
        myCommand.Parameters.AddWithValue( "@date", selectedDate);
        myConnection.Open();
        numa = myCommand.ExecuteNonQuery();
        myConnection.Close();

        Server.Transfer("pat_view_appointment.aspx");
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
                                <div class="page-title">Book Appointment</div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="card card-box">
                                <div class="card-head">
                                    <header>Book Appointment with Dr. <span id="docLabel" runat="server"></span></header>
                                </div>
                                <div class="card-body" id="cardBody" runat="server">
                                    <form action="#" id="form_sample_1" class="form-horizontal" runat="server">
                                        <div class="form-body">
                                        	<div class="form-group row">
                                                <label class="control-label col-md-3">Date Of Appointment
                                                    <span class="required"> * </span>
                                                </label>
                                                <div class="col-md-5">
                                                    <span id="calendarOut" runat="server"></span>
                                                    <span id="scheduleOut" runat="server"></span>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="control-label col-md-3">Time</label>
                                                <span class="required"> * </span>
                                                <div class="col-md-5">
	                                                <asp:DropDownList ID="timePicker" runat="server" style="width:100%" class="form-control input-height" >
                                                            
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="control-label col-md-3">Reason for Visit
                                                    <span class="required"> * </span>
                                                </label>
                                                <div class="col-md-5">
                                                    <asp:TextBox ID="reason" runat="server" placeholder="Injury/Condition" class="form-control input-height"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="form-group row">
												<label class="control-label col-md-3">Additional Notes 
												</label>
												<div class="col-md-5">
                                                    <asp:TextBox ID="notes" runat="server" name="notes" class="form-control input-height"></asp:TextBox>
												</div>
											</div>
										</div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="offset-md-3 col-md-9">
                                                    <div id="resultOut" runat="server"></div>
                                                    <asp:button runat="server" type="submit" class="btn btn-info" Text="Submit" OnClick="validate" UseSubmitBehavior="False"></asp:button>
                                                    <asp:button runat="server" type="button" class="btn btn-default" Text="Cancel" PostBackUrl="pat_view_appointment.aspx" UseSubmitBehavior="False"></asp:button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="card-body" runat="server" id="requestDiv" visible="false" style="text-align:center">
                                    <form runat="server" id="requestForm">
                                        <div id="requestTag" runat="server">

                                        </div>
                                        <br />
                                        <div id="requestButtons" runat="server">
                                            <asp:Button id='requestButton'  type='button' runat="server" onClick='requestAppt' Text='Request'/>
                                            <asp:Button id='returnButton' type='button' Text='Return' runat="server" PostBackUrl="pat_select_doctor.aspx" />
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
    </div>
    <!-- start js include path -->
    <script src="plugins/jquery/jquery.min.js" ></script>
	<script src="plugins/popper/popper.min.js" ></script>
    <script src="plugins/jquery-blockui/jquery.blockui.min.js" ></script>
	<script src="plugins/jquery-slimscroll/jquery.slimscroll.js"></script>
    <script src="plugins/jquery-validation/js/jquery.validate.min.js" ></script>
    <script src="plugins/jquery-validation/js/additional-methods.min.js" ></script>
    <!-- bootstrap -->
    <script src="plugins/bootstrap/js/bootstrap.min.js" ></script>
    <script src="plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
    <script src="plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker-init.js"></script>
    <!-- Common js-->
	<script src="js/app.js" ></script>
    <script src="js/pages/validation/form-validation.js" ></script>
    <script src="js/layout.js" ></script>
	<script src="js/theme-color.js" ></script>
	<!-- Material -->
	<script src="plugins/material/material.min.js"></script>
     <!-- end js include path -->
</body>
</html>