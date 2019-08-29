using DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminTools : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblTime.Text = DateTime.Now.ToString("hh:mm:ss tt");
        }
    }

    protected void GetTime(object sender, EventArgs e)
    {
        lblTime.Text = DateTime.Now.ToString();
    }

    protected void btnResetTimer_Click(object sender, EventArgs e)
    {
        try
        {
            using (DriveThruEntities db = new DriveThruEntities())
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),"load","$('#pre-loader').css('display', 'block');",true);
                var tblSensorData1 = db.tblSensorData1.ToList();
                var tblSensorData2 = db.tblSensorData2.ToList();
                var tblSensorData3 = db.tblSensorData3.ToList();

                db.tblSensorData1.RemoveRange(tblSensorData1);
                db.tblSensorData2.RemoveRange(tblSensorData2);
                db.tblSensorData3.RemoveRange(tblSensorData3);

                db.SaveChanges();

                Response.Redirect("DriveThruTimer.aspx");
            }
        }
        catch (Exception ex)
        {
            utility.log(ex.ToString());
        }
    }
}