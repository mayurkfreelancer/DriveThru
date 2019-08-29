using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for webhook
/// </summary>
public class webhook
{
    public webhook()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public class Rootobject
    {
        public Gatewaymessage gatewayMessage { get; set; }
        public Sensormessage[] sensorMessages { get; set; }
    }

    public class Gatewaymessage
    {
        public string gatewayID { get; set; }
        public string gatewayName { get; set; }
        public string accountID { get; set; }
        public string networkID { get; set; }
        public string messageType { get; set; }
        public string power { get; set; }
        public string batteryLevel { get; set; }
        public string date { get; set; }
        public string count { get; set; }
        public string signalStrength { get; set; }
        public string pendingChange { get; set; }
    }

    public class Sensormessage
    {
        public string sensorID { get; set; }
        public string sensorName { get; set; }
        public string applicationID { get; set; }
        public string networkID { get; set; }
        public string dataMessageGUID { get; set; }
        public string state { get; set; }
        public string messageDate { get; set; }
        public string rawData { get; set; }
        public string dataType { get; set; }
        public string dataValue { get; set; }
        public string plotValues { get; set; }
        public string plotLabels { get; set; }
        public string batteryLevel { get; set; }
        public string signalStrength { get; set; }
        public string pendingChange { get; set; }
    }

}