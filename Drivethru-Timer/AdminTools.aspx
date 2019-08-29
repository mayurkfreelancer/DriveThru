<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminTools.aspx.cs" Inherits="AdminTools" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Drive Thru</title>
    <!-- bootstrap -->
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
    <!-- font-awesome.min -->
    <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css" />
    <!-- Style -->
    <link rel="stylesheet" type="text/css" href="css/style.css?v=1.8" />
    <!-- Font -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700" rel="stylesheet" />
</head>
<body>
    <div id="pre-loader">
        <img src="images/loader-01.svg" alt="" />
    </div>
    <form id="form1" runat="server">
         <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <header class="header">
            <div class="container">
                <div class="row">
                    <div class="col-sm-6">
                        <div class="left-side">
                            <h2>Drive Thru Timer</h2>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="right-side">
                            <h5>Current Date / Time
                                 <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <asp:Label ID="lblTime" runat="server" />
                                        <asp:Timer ID="Timer1" runat="server" OnTick="GetTime" Interval="1000" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </h5>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <section>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-8 text-center">
                        <a class="btn btn-outline-secondary d-block mb-3" href="#">ADMIN TOOLS</a>
                        <asp:Button ID="btnResetTimer" runat="server" CssClass="btn btn-outline-secondary" Text="RESET TIMER" OnClick="btnResetTimer_Click" OnClientClick="Pre_loader();" />
                        <%--<a class="btn btn-outline-secondary" href="#">RESET TIMER</a>--%>
                        <a class="btn btn-outline-secondary" href="#">DRIVE THRU # </a>
                    </div>
                </div>
            </div>
        </section>
        <section>
            <div class="container">
                <div class="row">
                    <div class="col-sm-12 text-sm-right text-center">
                        <a class="btn btn-outline-secondary" href="DriveThruTimer.aspx">DRIVE THRU TIMER SCREEN</a>
                    </div>
                </div>
            </div>
        </section>
    </form>
    <!-- jquery -->
    <script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>

    <!-- bootstrap -->
    <script type="text/javascript" src="js/bootstrap.min.js"></script>

    <script type="text/javascript">
        var dt = new Date();
        //document.getElementById("datetime").innerHTML = (("0" + dt.getDate()).slice(-2)) + "/" + (("0" + (dt.getMonth() + 1)).slice(-2)) + "/" + (dt.getFullYear()) + " " + (("0" + dt.getHours()).slice(-2)) + ":" + (("0" + dt.getMinutes()).slice(-2));

        function clock() {
            // We create a new Date object and assign it to a variable called "time".
            var todayDate = new Date();
            var tzDifference = 11 * 60 + todayDate.getTimezoneOffset();
            // Access the "getHours" method on the Date object with the dot accessor.
            var time = new Date(todayDate.getTime());
            hours = time.getHours(),
                // Access the "getMinutes" method with the dot accessor.
                minutes = time.getMinutes(),
                seconds = time.getSeconds();
            Months = time.getMonth() + 1;
            //alert(time.getDay());
            document.getElementById("datetime").innerHTML = time.getDate() + "/" + Months + "/" + time.getFullYear() + " " + harold(hours) + ":" + harold(minutes) + ":" + harold(seconds);
        }
        function harold(standIn) {
            if (standIn < 10) {
                standIn = '0' + standIn
            }
            return standIn;
        }

        function Pre_loader() {
            $('#pre-loader').css("display", "block");
        }

        $(document).ready(function () {
            //setInterval(clock, 1000);
            $('#pre-loader').delay(0).fadeOut('slow');

        });
    </script>

</body>
</html>
