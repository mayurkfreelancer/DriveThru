using DAL;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DriveThruTimer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblTime.Text =  DateTime.Now.ToString("hh:mm:ss tt");

            //TimeZoneInfo targetZone = TimeZoneInfo.FindSystemTimeZoneById("Central Standard Time");
            //DateTime newDT = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, targetZone);

            //lblTime.Text = newDT.ToString();
        }
    }

    protected void GetTime(object sender, EventArgs e)
    {
        //lblTimeLocal.Text = DateTime.Now.ToString();

        TimeZoneInfo targetZone = TimeZoneInfo.FindSystemTimeZoneById("Central Standard Time");
        DateTime newDT = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, targetZone);

        lblTime.Text = newDT.ToString();
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string GetSensorData()
    {
        using (DriveThruEntities DB = new DriveThruEntities())
        {
            var SensorData1 = DB.tblSensorData1.OrderBy(x => x.DateTime).Take(5).ToList();
            var SensorData2 = DB.tblSensorData2.OrderBy(x => x.DateTime).Take(5).ToList();
            var SensorData3 = DB.tblSensorData3.OrderBy(x => x.DateTime).Take(5).ToList();
            var CurrentDateTime = DateTime.Now;

            return JsonConvert.SerializeObject(new { success = true, SensorData1 = SensorData1, SensorData2 = SensorData2, SensorData3 = SensorData3, CurrentDateTime = CurrentDateTime });
        }
        return JsonConvert.SerializeObject(new { success = false });
    }
}