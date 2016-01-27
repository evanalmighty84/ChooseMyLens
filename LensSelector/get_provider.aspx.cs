using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class get_provider : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["HoyaLensConn"].ConnectionString);
  
        SqlDataAdapter sda;
        DataSet ds = new DataSet();
        if (!string.IsNullOrEmpty(Request.QueryString["gid"]))
        {
            sda = new SqlDataAdapter("usp_getlocations", sqlConnection);
            sda.SelectCommand.Parameters.Add(new SqlParameter("@PracticeId", Convert.ToInt32(Request.QueryString["gid"])));
        }
        else if(!string.IsNullOrEmpty(Request.QueryString["lid"]))
        {
            sda = new SqlDataAdapter("usp_getLocation", sqlConnection);
            sda.SelectCommand.Parameters.Add(new SqlParameter("@LocationId", Convert.ToInt32(Request.QueryString["lid"])));
        }
        else
        {
            sda = new SqlDataAdapter("usp_getlocations", sqlConnection);
            if (!string.IsNullOrEmpty(Request.QueryString["zipcode"]))
            {
                sda.SelectCommand.Parameters.Add(new SqlParameter("@zipcode", Request.QueryString["zipcode"]));
            }
            else
            {
                sda.SelectCommand.Parameters.Add(new SqlParameter("@State", Request.QueryString["state"]));
                sda.SelectCommand.Parameters.Add(new SqlParameter("@City", Request.QueryString["city"]));
            }
        }
        sda.SelectCommand.CommandType = CommandType.StoredProcedure;

        sda.Fill(ds);
        string dataout = "{\"results\": [";
        bool first = true;
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            if (!first)
            {
                dataout += ",";
            }
            dataout += "{\"id\": \"" + dr["Location_id"].ToString() + "\", \"name\": \"" + dr["store"].ToString() + "\", \"address\": \"" + dr["address"].ToString() + "\", \"city\": \"" + dr["city"].ToString() + "\",\"state\": \"" + dr["state"].ToString() + "\",\"zip\": \"" + dr["zipcode"].ToString() + "\",\"phone\": \"" + dr["phone"].ToString() + "\" ,\"url\": \"" + dr["url"].ToString() + "\" ,\"certs\": \"" + dr["certs"].ToString() + "\"}";
            first = false;
        }
        dataout += "]}";
        Response.Write(dataout);
        Response.End();
    }
}
