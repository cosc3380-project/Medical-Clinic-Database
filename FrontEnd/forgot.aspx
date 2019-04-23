<%@Page Language="C#"%>
<%@Import Namespace="System.Data" %>
<%@Import Namespace="System.Data.SqlClient" %>
<%@Import Namespace="System.Text.RegularExpressions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Forgot Password</title>
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
</head>
<script language="C#" runat="server">
    void validate(Object sender, EventArgs e)
    {
        string strSelect;
        string strConnect;

        strSelect ="SELECT Log_User_Type FROM login WHERE Log_User_Name = @uName";
        strConnect="server=AUCKLAND;database=gl1517;uid=gl1517;pwd=MSX44gdnE";

        SqlConnection myConnection = new SqlConnection(strConnect);
        myConnection.Open();

        SqlCommand myCommand = new SqlCommand(strSelect, myConnection);
        myCommand.Parameters.AddWithValue( "@uName", uName.Text);

        SqlDataReader objDataReader;
        objDataReader = myCommand.ExecuteReader();
        if (objDataReader.Read())
        {
            if (objDataReader["Log_User_Type"].Equals("P"))
                result.InnerHtml = "A password reset email has been sent to the email address registered to " + uName.Text;
            else if (objDataReader["Log_User_Type"].Equals("D"))
                result.InnerHtml = "A password reset email has been sent to the email address registered to " + uName.Text;
            else if (objDataReader["Log_User_Type"].Equals("A"))
                result.InnerHtml = "A password reset email has been sent to the email address registered to " + uName.Text;
        }
        else
            result.InnerHtml = "Account details not found.";
        objDataReader.Close();
        myConnection.Close();
    }
</script>
<body>

    <div class="limiter">
        <div class="container-login100">
            <div class="wrap-login100 p-b-160 p-t-50">
                <form class="login100-form validate-form" runat="server">
                    <span class="login100-form-title p-b-43" id="header" runat="server">
                        Recover Your password
                    </span>

                    <div class="wrap-input100 rs1 validate-input" data-validate="Username is required">
                        <asp:TextBox runat="server" maxlength="20" name="uName" id="uName" class="input100" type="text" />
                        <span class="label-input100">User Name</span>
                    </div>
                    
                    <div class="container-login100-form-btn">
                        <asp:button class="login100-form-btn" runat="server" Text="Reset Password" OnClick="validate" UseSubmitBehavior="False" />
                    </div>

                    <div class="text-center w-full p-t-23">
                        <a href="login.aspx" class="txt1">
                            Return to Login page
                        </a>
                    </div>

                    <div class="text-center w-full p-t-23">
                        <p style="color: white" id="result" runat="server"></p>
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

</body>

</html>