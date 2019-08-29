<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DriveThruTimer.aspx.cs" Inherits="DriveThruTimer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Drive Thru </title>
    <!-- bootstrap -->
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />

    <!-- font-awesome.min -->
    <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css" />

    <!-- Style -->
    <link rel="stylesheet" type="text/css" href="css/style.css?v=1.8" />

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700" rel="stylesheet" />


    <style>
        .flash-button-blue {
            background: #0008a3;
            padding: 5px 10px;
            color: #fff;
            border: none;
            animation-name: flash;
            animation-duration: 1s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
        }

        .flash-button-red {
            background: #f00;
            padding: 5px 10px;
            color: #fff;
            border: none;
            animation-name: flash;
            animation-duration: 1s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
        }

        .flash-button-footer {
            background: #000000;
            padding: 15px;
            border: none;
            color: #fff;
            animation-name: flash;
            animation-duration: 1s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
        }

        @keyframes flash {
            0% {
                opacity: 1.0;
            }

            50% {
                opacity: 0.5;
            }

            100% {
                opacity: 1.0;
            }
        }
    </style>
</head>
<body>
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
                                        <asp:Label ID="lblTimeLocal" runat="server" />
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
                <div class="row">
                    <div class="col-md-12">
                        <h2>LANE 1</h2>
                    </div>
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th scope="col"></th>
                                        <th scope="col">Car 1 <i class="fa fa-car" aria-hidden="true"></i></th>
                                        <th scope="col">Car 2 <i class="fa fa-car" aria-hidden="true"></i></th>
                                        <th scope="col">Car 3 <i class="fa fa-car" aria-hidden="true"></i></th>
                                        <th scope="col">Car 4 <i class="fa fa-car" aria-hidden="true"></i></th>
                                        <th scope="col">Car 5 <i class="fa fa-car" aria-hidden="true"></i></th>
                                    </tr>
                                </thead>
                                <tbody id="tableSensorDataTime">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section>
            <div class="container">
                <div class="row">
                    <div class="col-sm-6">
                        <a class="btn btn-outline-secondary" href="AdminTools.aspx">GO TO ADMIN </a>
                    </div>
                    <div class="col-sm-6">
                        <div class="info-block text-red flash-button-footer">
                            Most Recent Car<br>
                            Date:
                            <asp:Label ID="lblDate" runat="server"></asp:Label>
                            <br>
                            Total Time:
                            <asp:Label ID="lblTotalTime" runat="server"></asp:Label><br>
                            Time Exited:
                            <asp:Label ID="lblTimeExited" runat="server"></asp:Label>
                        </div>
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
        //var dt = new Date();
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
    </script>
    <script>
        $(document).ready(function () {
            //setInterval(clock, 1000);
            LoadDriveThruData();
            setInterval(LoadDriveThruData, 5000);
        });
        function LoadDriveThruData() {
            $.ajax({
                type: 'POST',
                url: 'DriveThruTimer.aspx/GetSensorData',
                contentType: 'application/json; charset=utf-8',
                dataType: "json",
                async: false,
                success: function (response) {
                    var successResult = jQuery.parseJSON(response.d);
                    var SensorData1 = successResult.SensorData1;
                    var SensorData2 = successResult.SensorData2;
                    var SensorData3 = successResult.SensorData3;
                    if (successResult.success) {
                        console.log(SensorData1);
                        console.log(SensorData2);
                        console.log(SensorData3);
                        var str = "";
                        var str1 = "";
                        $('#tableSensorDataTime').html('');
                        $('#tableSensorTimeOffer').html('');
                        var matrixtable = '<tr>';
                        var matrixtable1 = '<tr>';
                        var matrixtable2 = '<tr>';
                        matrixtable += '<th scope="row">Time at <br> Menuboard</th>'
                        matrixtable1 += '<th scope="row">Time after <br> Ordering</th>'
                        matrixtable2 += '<th scope="row">Total Time</th>'
                        var temp = 1;
                        var CurrentDateTime = successResult.CurrentDateTime.split(/\.(?=[^\.]+$)/);
                        $(SensorData1).each(function (item) {
                            if (typeof SensorData1[item] != 'undefined' && typeof SensorData2[item] != 'undefined' && typeof SensorData3[item] != 'undefined') {
                                var Recent_Car = new Date(SensorData3[item].DateTime);
								//console.log(Recent_Car.toLocaleString('en-US', {timeZone: 'Central Standard Time'}));
                                Months = Recent_Car.getMonth() + 1;
                                var Rec_Date = Months + "/" + Recent_Car.getDate() + "/" + Recent_Car.getFullYear();
                                var TotalTime = GetTime(SensorData3[item].DateTime, SensorData1[item].DateTime);
                                var Exited_Time = GetTime(CurrentDateTime[0], SensorData3[item].DateTime);

                                document.getElementById("lblDate").innerHTML = Rec_Date;
                                document.getElementById("lblTotalTime").innerHTML = TotalTime;
                                document.getElementById("lblTimeExited").innerHTML = SensorData3[item].DateTime.split('T')[1]; //Exited_Time;
                            }
                            else {
                                //if (temp <= 4)
                                {
                                    var TimeAtMenuBoard;
                                    var TimeAfterOrder
                                    if (typeof SensorData2[item] === 'undefined') {
                                        console.log("11");
                                        TimeAtMenuBoard = GetTime(CurrentDateTime[0], SensorData1[item].DateTime);
                                    }
                                    else {
                                        console.log("22");
                                        TimeAtMenuBoard = GetTime(SensorData2[item].DateTime, SensorData1[item].DateTime);
                                    }
                                    if (typeof SensorData3[item] === 'undefined') {
                                        //if (SensorData3.length < temp) {
                                        if (typeof SensorData2[item] === 'undefined') {
                                            //if (SensorData2.length < temp) {
                                            console.log("33");
                                            TimeAfterOrder = GetTime(CurrentDateTime[0], CurrentDateTime[0]); //new Date().getDate()
                                        }
                                        else {
                                            console.log("44");
                                            TimeAfterOrder = GetTime(CurrentDateTime[0], SensorData2[item].DateTime);
                                        }
                                    }
                                    else {
                                        if (typeof SensorData2[item] === 'undefined') {
                                            //if (SensorData2.length < temp) {
                                            console.log("55");
                                            TimeAfterOrder = GetTime(CurrentDateTime[0], SensorData3[item].DateTime); //new Date().getDate()
                                        } else {
                                            console.log("66");
                                            TimeAfterOrder = GetTime(SensorData3[item].DateTime, SensorData2[item].DateTime);
                                        }
                                    }
                                    var TotalSum;
                                    //if (SensorData3.length < temp) {
                                    if (typeof SensorData3[item] === 'undefined') {
                                        console.log("77");
                                        TotalSum = GetTime(CurrentDateTime[0], SensorData1[item].DateTime);
                                        //TotalSum = addTimes(CurrentDateTime[0], SensorData1[item].DateTime);
                                        //document.getElementById("lblDate").innerHTML = SensorData3[item].DateTime;
                                    }
                                    else {
                                        console.log("88");
                                        TotalSum = GetTime(SensorData3[item].DateTime, SensorData1[item].DateTime);
                                        //TotalSum = addTimes(SensorData1[item].DateTime, SensorData2[item].DateTime);
                                        //document.getElementById("lblDate").innerHTML = SensorData3[item].DateTime;
                                    }
                                    //alert(TotalSum);
                                    var hour = 0;
                                    var minute = 0;
                                    var second = 0;
                                    var splitTime1 = TimeAtMenuBoard.split(':');
                                    var splitTime2 = TimeAfterOrder.split(':');
                                    console.log("splitTime1:-" + splitTime1);
                                    console.log("splitTime2:-" + splitTime2);
                                    hour = parseInt(splitTime1[0]) + parseInt(splitTime2[0]);
                                    minute = parseInt(splitTime1[1]) + parseInt(splitTime2[1]);
                                    //alert("minute:-" + minute);
                                    //hour = hour + minute / 60;
                                    //minute = minute % 60;
                                    //second = parseInt(splitTime1[2]) + parseInt(splitTime2[2]);
                                    //minute = minute + second / 60;
                                    //second = second % 60;
                                    console.log("Time At Menu " + item + " : " + TimeAtMenuBoard);
                                    console.log("Time After Order " + item + " : " + TimeAfterOrder);
                                    matrixtable += "<td>" + TimeAtMenuBoard + "</td>";
                                    matrixtable1 += "<td>" + TimeAfterOrder + "</td>";
                                    if (minute >= 10) {
                                        matrixtable2 += "<td class='flash-button-red'>" + TotalSum + "</td>";
                                    }
                                    else if (minute >= 7) {
                                        matrixtable2 += "<td class='flash-button-blue'>" + TotalSum + "</td>";
                                    }
                                    else {
                                        matrixtable2 += "<td>" + TotalSum + "</td>";
                                    }
                                    //if (minute >= 10) {
                                    //    matrixtable2 += "<td class='flash-button-blue'>" + TotalSum + "</td>";
                                    //}
                                    //else if (minute >= 7) {
                                    //    matrixtable2 += "<td class='flash-button-red'>" + TotalSum + "</td>";
                                    //}
                                    //else {
                                    //    matrixtable2 += "<td>" + TotalSum + "</td>";
                                    //}
                                    //matrixtable2 += "<td>" + TotalSum + "</td>";
                                }
                                temp = temp + 1;
                            }
                        });
                        matrixtable2 += '</tr>';
                        matrixtable1 += matrixtable2 + '</tr>';
                        matrixtable += matrixtable1 + '</tr>';
                        $('#tableSensorDataTime').append(matrixtable);
                        $('#tableSensorTimeOffer').append(str1);

                    }
                },
                error: function (Err) {
                    console.log(Err);
                }
            });
        }
        function GetTime(Date1, Date2) {
            //var StartDate = new Date(Date1);
            //var EndDate = new Date(Date2);

            var StartDate = new Date(Date2);
            var EndDate = new Date(Date1);

            //alert("StartDate:-" + StartDate.getTime());
            //alert("EndDate:-" + EndDate.getTime());

            var TimeDiffer = (EndDate.getTime() - StartDate.getTime()) / 1000;

            //alert("TimeDiffer:-" + TimeDiffer)
            //var date1 = new Date(Date1);
            //var date2 = new Date(Date2);
            //var msec = date2 - date1;
            //var mins = Math.floor(msec / 60000);
            //var hrs = Math.floor(mins / 60);
            //var days = Math.floor(hrs / 24);
            //var yrs = Math.floor(days / 365);
            //console.log("In minutes: ", mins + " minutes");
            //mins = mins % 60;
            //console.log("In hours: ", hrs + " hours, " + mins + " minutes");
            //hrs = hrs % 24;
            //console.log("In days: ", days + " days, " + hrs + " hours, " + mins + " minutes");
            //alert(TimeDiffer);


            //var res = Math.abs(StartDate - EndDate) / 1000;
            //console.log("<br>res: " + res);
            //// get total days between two dates
            //var days = Math.floor(res / 86400);
            //console.log("<br>Difference (Days): " + days);

            //// get hours        
            //var hours = Math.floor(res / 3600) % 24;
            //console.log("<br>Difference (Hours): " + hours);

            //// get minutes
            //var minutes = Math.floor(res / 60) % 60;
            //console.log("<br>Difference (Minutes): " + minutes);

            //// get seconds
            //var seconds = res % 60;
            //console.log("<br>Difference (Seconds): " + seconds);  


            if (TimeDiffer < 3600) {
                var hour = Math.floor(TimeDiffer / 3600);
                var minute = Math.floor(TimeDiffer % 3600 / 60);
                var second = Math.floor(TimeDiffer % 3600 % 60);
                return (hour + "h:" + minute + "m:" + second + "s");
            }
            else {
                var hour = Math.floor(TimeDiffer / 3600);
                var minute = Math.floor(TimeDiffer % 3600 / 60);
                var second = Math.floor(TimeDiffer % 3600 % 60);
                return (hour + "h:" + minute + "m:" + second + "s");
            }
        }

        function addTimes(startTime, endTime) {
            debugger;
            var times = [0, 0, 0]
            var max = times.length

            var a = (startTime || '').split('T');
            var b = (endTime || '').split('T');

            var c = a[1].split(':');
            var d = b[1].split(':');

            // normalize time values
            for (var i = 0; i < max; i++) {
                c[i] = isNaN(parseInt(c[i])) ? 0 : parseInt(c[i])
                d[i] = isNaN(parseInt(d[i])) ? 0 : parseInt(d[i])
            }

            // store time values
            for (var i = 0; i < max; i++) {
                times[i] = c[i] + d[i]
            }

            var hours = times[0]
            var minutes = times[1]
            var seconds = times[2]

            if (seconds >= 60) {
                var m = (seconds / 60) << 0
                minutes += m
                seconds -= 60 * m
            }

            if (minutes >= 60) {
                var h = (minutes / 60) << 0
                hours += h
                minutes -= 60 * h
            }

            if (hours >= 24) {
                hours = hours % 24;
                hours = hours < 0 ? 24 + hours : +hours;
            }

            return ('0' + hours).slice(-2) + 'h:' + ('0' + minutes).slice(-2) + 'm:' + ('0' + seconds).slice(-2) + 's'
        }

    </script>
</body>
</html>
