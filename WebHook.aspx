<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WebHook.aspx.cs" Inherits="WebHook" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h3 style="text-align: center">Web Hook Data</h3>
            <h4>
                <asp:Label ID="lblNoData" runat="server" Style="margin: auto; display: table; border: 0px solid red;"></asp:Label></h4>

                <%--Guid dataMessageGUID = new Guid(Request.QueryString.Get("dataMessageGUID"));<br />
                int sensorID = Convert.ToInt32(Request.QueryString.Get("sensorID"));<br />
                string sensorName = Request.QueryString.Get("sensorName");<br />
                string messageDate = Request.QueryString.Get("messageDate");<br />
                int batteryLevel = Convert.ToInt32(Request.QueryString.Get("batteryLevel"));<br />
                int gatewayID = Convert.ToInt32(Request.QueryString.Get("gatewayID"));<br />
                int signalStrength = Convert.ToInt32(Request.QueryString.Get("signalStrength"));<br />
                string rawData = Request.QueryString.Get("rawData");<br />--%>
        </div>
    </form>
</body>
</html>
