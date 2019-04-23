<%@Page Language="C#"%>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="System.Data.SqlClient" %>
<%@Import Namespace="System.Text.RegularExpressions" %>
<HTML>
	<HEAD>
        <title>Sign In</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--===============================================================================================-->
        <link rel="icon" type="image/png" href="images/icons/favicon.ico" />
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="css/util-signin.css">
        <link rel="stylesheet" type="text/css" href="css/main-signin.css">
        <!--===============================================================================================-->
	</HEAD>
    <script language="C#" runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.LoadComplete += new EventHandler(Page_LoadComplete);
        }
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            clearCookies();
        }
        void validate(Object sender, EventArgs e)
        {
            string strSelect;
            string strConnect;

            strSelect ="SELECT Log_EID, Log_User_Type FROM login WHERE Log_User_Name = @uName AND Log_Pass = @uPass";
            strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";

            SqlConnection myConnection = new SqlConnection(strConnect);
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(strSelect, myConnection);
            myCommand.Parameters.AddWithValue( "@uName", uName.Text);
            myCommand.Parameters.AddWithValue( "@uPass", uPass.Text);

            SqlDataReader objDataReader;
            objDataReader = myCommand.ExecuteReader();
            if (objDataReader.Read())
            {
                header.InnerHtml = "Login successful for EID " + objDataReader["Log_EID"] + " of type " + objDataReader["Log_User_Type"];
                HttpCookie uInfo = new HttpCookie("uInfo");
                uInfo["EID"] = objDataReader["Log_EID"].ToString();
                uInfo["EType"] = objDataReader["Log_User_Type"].ToString();
                Response.Cookies.Add(uInfo);

                switch(objDataReader["Log_User_Type"].ToString())
                {
                    case "P":
                        header.InnerHtml = "Going to Patient Page";
                        Server.Transfer("pat_welcome.aspx");
                        break;
                    case "D":
                        header.InnerHtml = "Going to Doctor Page";
                        Server.Transfer("doc_ui.aspx");
                        break;
                    case "A":
                        header.InnerHtml = "Going to Office Admin Page";
                        Server.Transfer("oa_ui.aspx");
                        break;
                    default:
                        header.InnerHtml = "Unknown user type.";
                        break;
                }

            }
            else
                header.InnerHtml = "Login unsuccessful. Try again!";
            objDataReader.Close();
            myConnection.Close();
        }
        void clearCookies()
        {
            HttpCookie uInfo = new HttpCookie("uInfo");
            uInfo["EID"] = "";
            uInfo["EType"] = "";
            Response.Cookies.Add(uInfo);
        }
    </script>
	<BODY>
        <div class="limiter">
            <div class="container-login100">
                <div class="wrap-login100 p-b-160 p-t-50">
                    <form class="login100-form validate-form" runat="server">
                        <span class="login100-form-title p-b-43" id="header" runat="server">
                            Account Login
                        </span>

                        <div class="wrap-input100 rs1 validate-input" data-validate="Username is required">
                            <asp:TextBox runat="server" maxlength="20" name="uName" id="uName" class="input100" type="text" />
                            <span class="label-input100">Username</span>
                        </div>


                        <div class="wrap-input100 rs2 validate-input" data-validate="Password is required">
                            <asp:TextBox runat="server" maxlength="20" name="uPass" id="uPass" class="input100" type="text" TextMode="Password" />
                            <span class="label-input100">Password</span>
                        </div>

                        <div class="container-login100-form-btn">
                            <asp:button class="login100-form-btn" runat="server" Text="Sign in" OnClick="validate" UseSubmitBehavior="False" />
                        </div>

                        <div class="text-center w-full p-t-23">
                            <a href="forgot.aspx" class="txt1">
                                Forgot password?
                            </a>
                        </div>


                        <div class="text-center w-full p-t-23">
                            <a href="http://auckland.bauer.uh.edu/students/gl1517/cosc3380/signup.aspx" class="txt1">
                                <h6>
                                    <p style="color: white"> New here? Create an Account</p>
                                </h6>
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!--===============================================================================================-->
        <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/animsition/js/animsition.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/bootstrap/js/popper.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/select2/select2.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/daterangepicker/moment.min.js"></script>
        <script src="vendor/daterangepicker/daterangepicker.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/countdowntime/countdowntime.js"></script>
        <!--===============================================================================================-->
        <script src="js/main-signin.js"></script>

	</BODY>
</HTML>