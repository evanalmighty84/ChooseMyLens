using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class get_state : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["HoyaLensConn"].ConnectionString);
        SqlDataAdapter sda;
        DataSet ds = new DataSet();
        sda = new SqlDataAdapter("usp_getstate", sqlConnection);
            sda.SelectCommand.CommandType = CommandType.StoredProcedure;
        if (!string.IsNullOrEmpty(Request.QueryString["zipcode"]))
        {
            sda.SelectCommand.Parameters.Add(new SqlParameter("@zipcode", Request.QueryString["zipcode"]));   
        }
        sda.Fill(ds);
        string dataout="";
        if(ds.Tables.Count>0&& ds.Tables[0].Rows.Count>0)
        {
            dataout=ds.Tables[0].Rows[0]["state"].ToString();
        }
           
        Response.Write(dataout);
        Response.End();
    }
}
