using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for utility
/// </summary>
public class utility
{
    public utility()
    {

    }
    public static void log(string str)
    {
        try
        {
            string filePath = HttpContext.Current.Server.MapPath("~");// Directory.GetParent(Path.GetDirectoryName((new System.Uri(System.Reflection.Assembly.GetExecutingAssembly().CodeBase)).AbsolutePath)).ToString();
            filePath = Path.Combine(filePath, "Logs");
            if (!Directory.Exists(filePath))
            {
                Directory.CreateDirectory(filePath);
            }
            filePath += "\\logs-" + DateTime.Now.Day + "-" + DateTime.Now.Month + "-" + DateTime.Now.Year + ".txt";

            using (StreamWriter sw = System.IO.File.AppendText(filePath))
            {
                sw.WriteLine(str);
            }
        }
        catch (Exception) { }
    }

    public static void log(Exception ex)
    {
        try
        {
            string filePath = HttpContext.Current.Server.MapPath("~"); //Directory.GetParent(Path.GetDirectoryName((new System.Uri(System.Reflection.Assembly.GetExecutingAssembly().CodeBase)).AbsolutePath)).ToString();
            filePath = Path.Combine(filePath, "Logs");
            if (!Directory.Exists(filePath))
            {
                Directory.CreateDirectory(filePath);
            }
            filePath += "\\logs-" + DateTime.Now.Day + "-" + DateTime.Now.Month + "-" + DateTime.Now.Year + ".txt";

            using (StreamWriter sw = System.IO.File.AppendText(filePath))
            {
                int linenum = 0;
                Int32.TryParse(ex.StackTrace.Substring(ex.StackTrace.LastIndexOf(' ')), out linenum);
                sw.WriteLine("[" + DateTime.Now.ToString() + "] Exception[" + ex.Message + "]" + ex.StackTrace.Split(new string[] { "(" }, StringSplitOptions.RemoveEmptyEntries)[0] + "[Line No:" + linenum + "]");
            }
        }
        catch (Exception) { }
    }

    public static string GetApplicationRootVirtualPath()
    {
        string path = string.Empty;
        string folderSeparator = @"/";
        try
        {
            HttpRequest request = System.Web.HttpContext.Current.Request;

            path = request.Url.AbsoluteUri.Replace(request.Url.PathAndQuery == "/" ? "" : request.Url.PathAndQuery, string.Empty) + request.ApplicationPath;

            if (!path.EndsWith(folderSeparator))
            {
                path += folderSeparator;
            }
        }
        catch (Exception err)
        {

        }
        return path;
    }
}