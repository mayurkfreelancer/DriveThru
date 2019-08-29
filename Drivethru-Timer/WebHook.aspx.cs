using DAL;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



public partial class WebHook : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            utility.log("===========================");
            utility.log("Webhook Received :- " + DateTime.Now);
            string documentContents;
            using (Stream receiveStream = Request.InputStream)
            {
                using (StreamReader readStream = new StreamReader(receiveStream, Request.ContentEncoding))
                {
                    documentContents = readStream.ReadToEnd();
                }
            }
            using (DriveThruEntities db = new DriveThruEntities())
            {

                webhook.Rootobject rats = JsonConvert.DeserializeObject<webhook.Rootobject>(documentContents);
                if (rats != null)
                {
                    utility.log("Sensor Data");
                    bool record1Deleted = false;
                    bool record2Deleted = false;
                    bool record3Deleted = false;
                    foreach (var item in rats.sensorMessages)
                    {
                        if (Convert.ToInt32(item.state) > 0)
                        {
                            utility.log("sensorName:-"+item.sensorName.ToString());
                            
                            tblSensorData oTbldb = new tblSensorData();
                            string sensorID = item.sensorID.ToString();
                            //utility.log(sensorID);
                            oTbldb.sensorID = sensorID;
                            string sensorName = item.sensorName.ToString();
                            //utility.log(sensorName);
                            oTbldb.sensorName = sensorName;
                            string applicationID = item.applicationID.ToString();
                            //utility.log(applicationID);
                            oTbldb.applicationID = applicationID;
                            string networkID = item.networkID.ToString();
                            //utility.log(networkID);
                            oTbldb.networkID = networkID;
                            string dataMessageGUID = item.dataMessageGUID.ToString();
                            utility.log("dataMsgId:" + dataMessageGUID);
                            oTbldb.dataMessageGUID = dataMessageGUID;
                            string state = item.state.ToString();
                            utility.log(state);
                            oTbldb.state = state;
                            string messageDate = item.messageDate.ToString();
                            //utility.log(messageDate);
                            oTbldb.messageDate = Convert.ToDateTime(messageDate);
                            string rawData = item.rawData.ToString();
                            //utility.log(rawData);
                            oTbldb.rawData = rawData;
                            string dataType = item.dataType.ToString();
                            //utility.log(dataType);
                            oTbldb.dataType = dataType;
                            string dataValue = item.dataValue.ToString();
                            //utility.log(dataValue);
                            oTbldb.dataValue = dataValue;
                            string plotValues = item.plotValues.ToString();
                            //utility.log(plotValues);
                            oTbldb.plotValues = plotValues;
                            string plotLabels = item.plotLabels.ToString();
                            //utility.log(plotLabels);
                            oTbldb.plotLabels = plotLabels;
                            string batteryLevel = item.batteryLevel.ToString();
                            //utility.log(batteryLevel);
                            oTbldb.batteryLevel = batteryLevel;
                            string signalStrength = item.signalStrength.ToString();
                            //utility.log(signalStrength);
                            oTbldb.signalStrength = signalStrength;
                            string pendingChange = item.pendingChange.ToString();
                            //utility.log(pendingChange);
                            oTbldb.pendingChange = pendingChange;
                            db.tblSensorDatas.Add(oTbldb);
                            db.SaveChanges();
                            //utility.log("============================");

                            DateTime today = DateTime.Today;

                            //utility.log("today:-" + today + "=========" + DateTime.Now);

                            string senSorname = item.sensorName.ToString().Split('-')[0].Trim();
                            utility.log("senSorname============================" + senSorname);
                            if (senSorname == "Sensor1")
                            {
                                utility.log("senSorname == Sensor1" + senSorname);
                                if (Convert.ToInt32(state) > 0)
                                {
                                    utility.log("Sensor 1");
                                    int? SequenceNumber = 1;
                                    var getSequenceNumber = db.tblSensorData1.OrderByDescending(x => x.Id).FirstOrDefault();
                                    if (getSequenceNumber != null)
                                    {
                                        utility.log("SequenceNumberfromDB:" + getSequenceNumber.SequenceNumber);
                                        SequenceNumber = (Math.Abs((int)getSequenceNumber.SequenceNumber))  + 1;
                                    }
                                    else
                                    {
                                        SequenceNumber = 1;
                                    }

                                    utility.log("SequenceNumberafterupdate:" + SequenceNumber);

                                    tblSensorData1 SensorData1 = new tblSensorData1();
                                    SensorData1.DateTime = Convert.ToDateTime(item.messageDate);
                                    SensorData1.SequenceNumber = SequenceNumber;
                                    SensorData1.dataMessageGUID = item.dataMessageGUID;
                                    db.tblSensorData1.Add(SensorData1);
                                    db.SaveChanges();
                                    utility.log("Successfully add record in tblSensorData1");
                                    utility.log("============================");

                                    var TotalRecord = db.tblSensorData1.ToList();

                                    if (TotalRecord.Count > 5 )
                                    {
                                        var deleteSensor1 = db.tblSensorData1.Where(x => x.SequenceNumber == 1).FirstOrDefault();
                                        if ( deleteSensor1 != null )
                                        {
                                            db.tblSensorData1.Remove(deleteSensor1);
                                            db.SaveChanges();
                                            record1Deleted = true;
                                        }

                                        var deleteSensor2 = db.tblSensorData2.Where(x => x.SequenceNumber == 1).FirstOrDefault();

                                        if ( deleteSensor2 != null )
                                        {
                                            db.tblSensorData2.Remove(deleteSensor2);
                                            db.SaveChanges();
                                            record2Deleted = true;
                                        }

                                        var deleteSensor3 = db.tblSensorData3.Where(x => x.SequenceNumber == 1).FirstOrDefault();
                                        if ( deleteSensor3 != null )
                                        {
                                            db.tblSensorData3.Remove(deleteSensor3);
                                            db.SaveChanges();
                                            record3Deleted = true;
                                        }
                                    }
                                }
                                //utility.log("Total Record record in tblSensorData1:-" + TotalRecord.Count);
                                //utility.log("============================");
                            }
                            if (senSorname == "Sensor 2")
                            {
                                if (Convert.ToInt32(state) > 0)
                                {
                                    utility.log("Sensor 2");
                                    int? SequenceNumberSensor1 = 1;
                                    var TotalRecord = db.tblSensorData1.ToList();
                                    utility.log("tblSensorData1 TotalRecord.Count:-" + TotalRecord.Count);
                                    if (TotalRecord.Count >= 1)
                                    {
                                        var getSequenceNumbersensor1 = db.tblSensorData1.OrderByDescending(x => x.Id).FirstOrDefault();
                                        if (getSequenceNumbersensor1 != null)
                                        {
                                            SequenceNumberSensor1 = Math.Abs((Int16)getSequenceNumbersensor1.SequenceNumber);
                                        }
                                        else
                                        {
                                            SequenceNumberSensor1 = SequenceNumberSensor1 + 1;
                                        }

                                        int? SequenceNumber = 1;
                                        var getSequenceNumber = db.tblSensorData2.OrderByDescending(x => x.Id).FirstOrDefault();
                                        if (getSequenceNumber != null)
                                        {
                                            SequenceNumber = getSequenceNumber.SequenceNumber + 1;
                                        }
                                        else
                                        {
                                            SequenceNumber = 1;
                                        }
                                        utility.log("SequenceNumberSensor1:-" + SequenceNumberSensor1 + " SequenceNumber:-" + SequenceNumber);
                                        //if (SequenceNumberSensor1 == SequenceNumber)
                                        {

                                            utility.log("SequenceNumber:" + SequenceNumber);
                                            utility.log("SequenceNumberSensor1:" + SequenceNumberSensor1);
                                            tblSensorData2 SensorData2 = new tblSensorData2();
                                            SensorData2.DateTime = Convert.ToDateTime(item.messageDate);
                                            SensorData2.SequenceNumber = SequenceNumber;
                                            SensorData2.dataMessageGUID = item.dataMessageGUID;
                                            db.tblSensorData2.Add(SensorData2);
                                            db.SaveChanges();
                                            utility.log("Successfully add record in tblSensorData2");
                                            utility.log("============================");

                                        }
                                        //else
                                        {
                                            //utility.log("DELETE FROM tblSensorData1 : " + SequenceNumberSensor1);
                                            //var deleteSensor1 = db.tblSensorData1.Where(x => x.SequenceNumber == SequenceNumberSensor1).FirstOrDefault();
                                            //if (deleteSensor1 != null)
                                            //{
                                             //   db.tblSensorData1.Remove(deleteSensor1);
                                               // db.SaveChanges();
                                            //}
                                        }
                                    }
                                }
                                //var TotalRecord = db.tblSensorData2.ToList();

                                //if (TotalRecord.Count > 5)
                                //{
                                //    var deleteSensor1 = db.tblSensorData2.Where(x=>x.SequenceNumber == 1).FirstOrDefault();

                                //    if (deleteSensor1 != null)
                                //    {
                                //        db.tblSensorData2.Remove(deleteSensor1);
                                //        db.SaveChanges();
                                //    }
                                //}
                                //utility.log("Total Record record in tblSensorData2:-" + TotalRecord.Count);
                                //utility.log("============================");
                            }
                            if (senSorname == "Sensor 3")
                            {
                                if (Convert.ToInt32(state) > 0)
                                {
                                    utility.log("Sensor 3");
                                    int? SequenceNumberSensor2 = 1;
                                    var TotalRecord = db.tblSensorData2.ToList();
                                    utility.log("tblSensorData2 TotalRecord.Count:-" + TotalRecord.Count);
                                    if (TotalRecord.Count >= 1)
                                    {
                                        var getSequenceNumbersensor2 = db.tblSensorData2.OrderByDescending(x => x.Id).FirstOrDefault();
                                        if (getSequenceNumbersensor2 != null)
                                        {
                                            SequenceNumberSensor2 = Math.Abs((Int16)getSequenceNumbersensor2.SequenceNumber);
                                        }
                                        else
                                        {
                                            SequenceNumberSensor2 = SequenceNumberSensor2 + 1;
                                        }
                                        int? SequenceNumber = 1;
                                        var getSequenceNumber = db.tblSensorData3.OrderByDescending(x => x.Id).FirstOrDefault();
                                        if (getSequenceNumber != null)
                                        {
                                            SequenceNumber = Math.Abs((Int16)getSequenceNumber.SequenceNumber) + 1;
                                        }
                                        else
                                        {
                                            SequenceNumber = 1;
                                        }
                                        utility.log("SequenceNumberSensor2:" + SequenceNumberSensor2 + " SequenceNumber:" + SequenceNumber);
                                        //if (SequenceNumberSensor2 == SequenceNumber)
                                        {

                                            utility.log("SequenceNumber:-" + SequenceNumber);
                                            utility.log("SequenceNumberSensor2:-" + SequenceNumberSensor2);
                                            tblSensorData3 SensorData3 = new tblSensorData3();
                                            SensorData3.DateTime = Convert.ToDateTime(item.messageDate);
                                            SensorData3.SequenceNumber = SequenceNumber;
                                            SensorData3.dataMessageGUID = item.dataMessageGUID;
                                            db.tblSensorData3.Add(SensorData3);
                                            db.SaveChanges();
                                            utility.log("Successfully add record in tblSensorData3");
                                            utility.log("============================");

                                        }
                                        //else
                                        {
                                           // utility.log("DELETE FROM tblSensorData2 :- " + SequenceNumberSensor2);
                                           // var deleteSensor2 = db.tblSensorData2.Where(x => x.SequenceNumber == SequenceNumberSensor2).FirstOrDefault();

                                           // if (deleteSensor2 != null)
                                           //{
                                               // db.tblSensorData2.Remove(deleteSensor2);
                                               // db.SaveChanges();
                                            //}
                                        }
                                    }
                                }
                                //var TotalRecord = db.tblSensorData3.ToList();

                                //if (TotalRecord.Count > 5)
                                //{
                                //    var deleteSensor1 = db.tblSensorData3.Where(x => x.SequenceNumber == 1).FirstOrDefault();
                                //    if (deleteSensor1 != null)
                                //    {
                                //        db.tblSensorData3.Remove(deleteSensor1);
                                //        db.SaveChanges();
                                //    }
                                //}
                                //utility.log("Total Record record in tblSensorData3:-" + TotalRecord.Count);
                                //utility.log("============================");
                            }
                        }
                    }
                }
            }
            utility.log("documentContents" + documentContents);
            utility.log("Webhook End :- " + DateTime.Now);
        }
        catch (Exception ex)
        {
            utility.log(ex.ToString());
        }
    }
}