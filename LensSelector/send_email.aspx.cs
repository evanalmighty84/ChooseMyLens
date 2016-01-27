using System;
using System.IO;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Xml.Linq;


public partial class send_email : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["sesssionId"]))
        {
            string htmlOut = File.ReadAllText(Server.MapPath("emails.html"));
            DataSet ds = new DataSet();
           
            SqlConnection scon = new SqlConnection(ConfigurationManager.ConnectionStrings["HoyaLensConn"].ConnectionString);
            SqlDataAdapter sda;
            sda = new SqlDataAdapter("usp_getUserRecs", scon);
            sda.SelectCommand.CommandType = CommandType.StoredProcedure;
            sda.SelectCommand.Parameters.Add(new SqlParameter("@sessionId", Request.QueryString["sesssionId"]));
            sda.Fill(ds);
            string emailAddress = ds.Tables[0].Rows[0]["EmailAddress"].ToString();
            string header = "<h1 style=\"color:#4a4d54; font-size:16px; margin-bottom:0px;\">{0}</h1>\n<p style=\"padding:0px; margin:0px;\">{1}, {2}, {3} {4}<br />Phone: {5}</p>     \n";
            //string certification = "<table border=0>{0}</table>";
            string certification = "{0}";
            if (ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
            {
                if (ds.Tables[1].Rows[0]["URL"].ToString() != "") 
                {
                    header = string.Format(header, "<a style=\"color:#f79600; text-decoration: none;\" href=\"" + ds.Tables[1].Rows[0]["URL"].ToString() + "\" target=\"_blank\">" + ds.Tables[1].Rows[0]["Name"] + "</a>", ds.Tables[1].Rows[0]["address1"].ToString() + " " + ds.Tables[1].Rows[0]["address2"].ToString(), ds.Tables[1].Rows[0]["city"], ds.Tables[1].Rows[0]["state"], ds.Tables[1].Rows[0]["zipcode"], ds.Tables[1].Rows[0]["phone"]);
                }
                else
                {
                    header = string.Format(header, ds.Tables[1].Rows[0]["Name"], ds.Tables[1].Rows[0]["address1"].ToString() + " " + ds.Tables[1].Rows[0]["address2"].ToString(), ds.Tables[1].Rows[0]["city"], ds.Tables[1].Rows[0]["state"], ds.Tables[1].Rows[0]["zipcode"], ds.Tables[1].Rows[0]["phone"]);
                }
                
                certification = string.Format(certification,ds.Tables[1].Rows[0]["Certification"]);
                if(string.IsNullOrEmpty(Request.QueryString["lid"]))
                {
                    Response.Redirect(Request.RawUrl+"&lid="+ds.Tables[1].Rows[0]["id"].ToString());
                }
            }
            else
            {
                header = "";
            }
            DoQuestions(ref htmlOut, ds.Tables[0].Rows[0]);
            string sectionHtml = "<p style=\"font-size:14px; font-weight:bold; padding:0px; margin:0px;\">{0}</p>\n<p style=\"font-weight :bold; font-size:24px; color:#0177c1; padding:0px; margin:0px;\">{1}</p><br />\n<p style=\"padding:0px; margin:0px; font-weight:bold;\">DESIGN:</p>{2}<br />\n<Br />\n<p style=\"padding:0px; margin:0px; font-weight:bold;\">MATERIALS:</p>\n{3}<br />\n<br />\n<p style=\"padding:0px; margin:0px; font-weight:bold;\">TREATMENT:</p>\n{4}";
            string specialHtml = "<table id=\"Table_01\" width=\"155\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#eeeeee\" style=\"font-family:Arial; font-size:12px;\">\n<tr>\n<td colspan=\"3\" width=\"155\" valign=\"top\" bgcolor=\"#eeeeee\">\n"+sectionHtml+"</tr>\n<tr>\n<td rowspan=\"3\" width=\"67\" height=\"41\" valign=\"top\" bgcolor=\"#eeeeee\">{5}</td>\n<td width=\"9\" height=\"3\" bgcolor=\"#eeeeee\" valign=\"top\"></td>\n<td rowspan=\"3\" width=\"79\" height=\"41\" valign=\"top\" bgcolor=\"#eeeeee\">&nbsp;{7}</td>\n</tr>\n<tr>\n<td width=\"9\" height=\"9\" valign=\"top\" bgcolor=\"{6}\"></td>\n</tr>\n<tr>\n<td width=\"7\" height=\"31\" valign=\"top\" bgcolor=\"#eeeeee\"></td>\n</tr>\n</table>\n";
//                "</td>\n	</tr>\n	<tr>\n		<td rowspan=\"2\" width=\"65\" height=\"40\" bgcolor=\"#eeeeee\" valign=\"top\">{5}</td>\n		<td rowspan=\"2\" width=\"2\" height=\"40\" bgcolor=\"#eeeeee\" valign=\"top\"></td>\n		<td width=\"9\" height=\"9\" valign=\"top\" bgcolor=\"#{6}\" ></td>\n		<td rowspan=\"2\" width=\"3\" height=\"40\" bgcolor=\"#eeeeee\" valign=\"top\"></td>\n		<td rowspan=\"2\" width=\"76\" height=\"40\" bgcolor=\"#eeeeee\" valign=\"top\">{7}";
            string[] lensRows = ds.Tables[0].Rows[0]["question_16"].ToString().Split('|');
            string[] primaryRow = lensRows[0].Split(',');
            string[] specialRow;
            string[] compRow;
            htmlOut = htmlOut.Replace("%%primary%%", BuildSection(sectionHtml, primaryRow, "PRIMARY LENS"));
            if (lensRows[1].StartsWith("Secondary"))
            {
                compRow = lensRows[1].Split(',');
                htmlOut = htmlOut.Replace("%%secondary%%", BuildSection(sectionHtml, compRow, "COMPLEMENTARY LENS"));
                if (lensRows.Length > 2)
                {
                    specialRow = lensRows[2].Split(',');

                    htmlOut = htmlOut.Replace("%%special%%", BuildSection(specialHtml, specialRow, ds.Tables[0].Rows[0]["question_14"].ToString(), ds.Tables[0].Rows[0]["question_15"].ToString(), "ff0000"));
                }
                else
                {
                    htmlOut = htmlOut.Replace("%%special%%", "");
                }
            }
            else
            {
                specialRow = lensRows[1].Split(',');
                htmlOut = htmlOut.Replace("%%secondary%%", BuildSection(specialHtml, specialRow, ds.Tables[0].Rows[0]["question_14"].ToString(), ds.Tables[0].Rows[0]["question_15"].ToString(), "ff0000"));
                htmlOut = htmlOut.Replace("%%special%%", "");
            }
            
            htmlOut = htmlOut.Replace("%%header%%", header);
            htmlOut = htmlOut.Replace("%%certification%%", certification);
            htmlOut = htmlOut.Replace("%%baseHref%%", ConfigurationManager.AppSettings["baseHref"]);
                //string.Format(htmlOut, header);
            if (!string.IsNullOrEmpty(Request.QueryString["print"]))
            {
                htmlOut = htmlOut.Replace("%%format%%", "<script type=\"text/javascript\">window.print();</script>");
                htmlOut = htmlOut.Replace("%%GA%%", "<script type=\"text/javascript\">var gaJsHost = ((\"https:\" == document.location.protocol) ? \"https://ssl.\" : \"http://www.\");\ndocument.write(unescape(\"%3Cscript src='\" + gaJsHost + \"google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E\"));\ntry {\nvar pageTracker = _gat._getTracker(\"UA-15476220-2\");\npageTracker._trackPageview();\n} catch(err) {}</script>");
                Response.Write(htmlOut);
            }
            else
            {
                htmlOut = htmlOut.Replace("%%format%%", "");
                htmlOut = htmlOut.Replace("%%GA%%", "");
                //Response.Write(htmlOut);
                Sendemail(htmlOut, emailAddress);
            }
        }
        else
        {
            Response.Write("false");
        }
        Response.End();
        
    }

    private void DoQuestions(ref string htmlOut, DataRow dataRow)
    {
        htmlOut = htmlOut.Replace("%indoors%", dataRow["Question_04"].ToString());
        string agerange = agerangeLookup(dataRow["Question_01"].ToString());
        htmlOut = htmlOut.Replace("%Age%", agerange);
        int Outdoor = 100 - int.Parse(dataRow["Question_04"].ToString());
        htmlOut = htmlOut.Replace("%outdoors%", Outdoor.ToString());
        htmlOut = htmlOut.Replace("%singlePair%", dataRow["Question_05"].ToString() == "true" ? "YES" : "NO");
        string[] glasses = dataRow["Question_07"].ToString().Split(',');
        string currentglasses = "";
        bool firstPair=true;
        if(glasses[0]=="true")
        {
            if(!firstPair)
            {
                currentglasses+=", ";
                
            }
            currentglasses += "single";
            firstPair = false;
        }
        if(glasses[1]=="true")
        {
            if(!firstPair)
            {
                currentglasses+=", ";
              
            }
            currentglasses += "progressive"; 
            firstPair = false;
        }
        if(glasses[2]=="true")
        {
            if(!firstPair)
            {
                currentglasses+=", ";
                
            }
            currentglasses += "bifocal";
            firstPair = false;
        }
        if(glasses[3]=="true")
        {
            if(!firstPair)
            {
                currentglasses+=", ";
               
            }
            currentglasses += "contacts";
            firstPair = false;
        }
        if (glasses[4] == "true")
        {
            if (!firstPair)
            {
                currentglasses += ", ";
                
            }
            currentglasses += "none";
            firstPair = false;
        }
        htmlOut = htmlOut.Replace("%glasses%", currentglasses.ToUpper());
        htmlOut = htmlOut.Replace("%senitive%", dataRow["Question_12"].ToString() == "true" ? "YES" : "NO");
        htmlOut = htmlOut.Replace("%driving%", dataRow["Question_10"].ToString() == "true" ? "YES" : "NO");
        htmlOut = htmlOut.Replace("%surgery%", dataRow["Question_11"].ToString() == "true" ? "YES" : "NO");
        htmlOut = htmlOut.Replace("%safety%", dataRow["Question_09"].ToString() == "true" ? "YES" : "NO");
        htmlOut = htmlOut.Replace("%sport%", dataRow["Question_14"].ToString().ToUpper());
        string nearfar = "NEAR SIGHTED";
        if(dataRow["Question_13"].ToString()=="1")
        {
            nearfar="FAR SIGHTED";
        }
        if(dataRow["Question_13"].ToString()=="2")
        {
            nearfar="BOTH";
        }
        htmlOut = htmlOut.Replace("%nearfar%", nearfar);
        string[] act = dataRow["Question_06"].ToString().Split(',');
        htmlOut = htmlOut.Replace("%act1%", act[0]);
        htmlOut = htmlOut.Replace("%act2%", act[1]);
        htmlOut = htmlOut.Replace("%act3%", act[2]);
        htmlOut = htmlOut.Replace("%act4%", act[3]);
        htmlOut = htmlOut.Replace("%act5%", act[4]);
        htmlOut = htmlOut.Replace("%act6%", act[5]);
        string[] features = new string[8];
        string[] items = dataRow["Question_08"].ToString().Split(',');
        features[int.Parse(items[0])-1] = "STYLE";
        features[int.Parse(items[1]) - 1] = "LENS THINNESS";
        features[int.Parse(items[2]) - 1] = "FRAME MATERIAL";
        features[int.Parse(items[3]) - 1] = "FIT";
        features[int.Parse(items[4]) - 1] = "LENS TYPE";
        features[int.Parse(items[5]) - 1] = "LENS COLOR";
        features[int.Parse(items[6]) - 1] = "DURABILITY";
        features[int.Parse(items[7]) - 1] = "WEIGHT";
        for (int i = 0; i < 8; i++)
        {
            htmlOut = htmlOut.Replace("%feature " + (i + 1) + "%", features[i]);
        }

    }

    private string agerangeLookup(string p)
    {
        string ageOut = "";
        switch (p)
        {
            case "18":
                ageOut = "under 19";
                break;
            case "19":
                ageOut = "19";
                break;
            case "20":
                ageOut = "20-30";
                break;
            case "25":
                ageOut = "20-30";
                break;
            case "30":
                ageOut = "31 - 40";
                break;
            case "35":
                ageOut = "31 - 40";
                break;
            case "40":
                ageOut = "41 - 50";
                break;
            case "45":
                ageOut = "41 - 50";
                break;
            case "50":
                ageOut = "51-60";
                break;
            case "55":
                ageOut = "51-60";
                break;
            case "60":
                ageOut = "61-70";
                break;
            case "65":
                ageOut = "61-70";
                break;
            case "70":
                ageOut = "71 - 80";
                break;
            case "75":
                ageOut = "71 - 80";
                break;
            case "80":
                ageOut = "80+";
                break;
            default:
                ageOut = p;
                break;
        }
        return ageOut;
    }

    private void Sendemail(string htmlOut, string emailAddress)
    {

        //if (emailAddress == null)
        //{
        //    emailAddress = emailAddress;

        //}
        //if (LensSelector.Properties.Settings.Default.isTesting)
        //{
        //    //representativeName = string.Format("TESTING: original SR: {0}, emailAddress)";
        //    emailAddress = LensSelector.Properties.Settings.Default.TestingEmail;
        //}
             
        try
        {
            SmtpClient sc = new SmtpClient(ConfigurationManager.AppSettings["smtp.Host"]);
            MailMessage mm = new MailMessage(ConfigurationManager.AppSettings["mail.from"], emailAddress);
            mm.Subject = "HOYA Lens Recommendation";
            mm.IsBodyHtml = true;
            mm.Body = htmlOut;
            sc.Send(mm);
        }
        catch (Exception ex)
        {
        }
        
    }

    private string BuildSection(string sectionHtml, string[] Row,string sectionName)
    {
        string designType = "Progressive: "+Row[1];
        if(Row[1].Contains("Nulux"))
        {
            designType="Single Vision: "+Row[1];
        }
        string Treatments = "";
        for(int x =3; x<Row.Count();x++)
        {
            Treatments+=Row[x]+"<br/>\n";
        }
        return string.Format(sectionHtml, sectionName, Row[1],designType, Row[2], Treatments);
    }
    private string BuildSection(string sectionHtml, string[] Row,string sport, string color, string colorNumber)
    {
        if (sport.ToLower() != "none")
        {
            string designType = "Progressive: " + Row[1];
            if (Row[1].Contains("Nulux"))
            {
                designType = "Single Vision: " + Row[1];
            }
            string Treatments = "";
            for (int x = 3; x < Row.Count(); x++)
            {
                Treatments += Row[x] + "<br/>\n";
            }
            string hexColor = getHex(color);
            //change this back before going live
            return string.Format(sectionHtml, "SPECIALTY LENS", Row[1], designType, Row[2], Treatments, sport, hexColor, color);
        }
        else
        {
            return "";
        }
    }

    private string getHex(string color)
    {
        TextReader tr = File.OpenText(Server.MapPath("colors.xml"));
        XDocument xdoc = XDocument.Load(tr);
        var xHex = from xe in xdoc.Element("colors").Elements("tint")
                   where xe.Attribute("id").Value.ToLower() == color.ToLower()
                   select xe.Element("hex").Value;
        tr.Close();
        string hexcolor = "#";
        return hexcolor + (xHex.Count() > 0 ? xHex.First() : "eeeeee");
    }
}
