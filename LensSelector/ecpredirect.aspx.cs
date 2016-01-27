using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class ecpredirect : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection scon = new SqlConnection(ConfigurationManager.ConnectionStrings["HoyaLensConn"].ConnectionString);
        SqlDataAdapter sda;
        DataSet ds = new DataSet();
        if (!string.IsNullOrEmpty(Request.QueryString["gid"]))
        {
            sda = new SqlDataAdapter("usp_getPractice", scon);
            sda.SelectCommand.Parameters.Add(new SqlParameter("PracticeId", Request.QueryString["gid"]));
            sda.SelectCommand.CommandType = CommandType.StoredProcedure;

            sda.Fill(ds);
            string doctorname = ds.Tables[0].Rows[0]["Name"].ToString();
            Response.Redirect("default.aspx?gid=" + Request.QueryString["gid"] + "&utm_medium=banner&utm_campaign=doctor_banners&utm_source=" + doctorname.Replace(" ", "_").Replace("&", ""));
        }
        else if (!string.IsNullOrEmpty(Request.QueryString["lid"]))
        {
            sda = new SqlDataAdapter("usp_getLocation", scon);
            sda.SelectCommand.Parameters.Add(new SqlParameter("LocationId", Request.QueryString["lid"]));
            sda.SelectCommand.CommandType = CommandType.StoredProcedure;

            sda.Fill(ds);
            string doctorname = ds.Tables[0].Rows[0]["store"].ToString();
            Response.Redirect("default.aspx?lid=" + Request.QueryString["lid"] + "&utm_medium=banner&utm_campaign=doctor_banners&utm_source=" + doctorname.Replace(" ", "_").Replace("&", ""));
        }        
    }
}
