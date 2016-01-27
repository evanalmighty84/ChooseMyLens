using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Data.SqlTypes;


    public partial class StartSession : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string cgiResponse = "";

            try
            {
                Guid newGuid = Guid.NewGuid();

                // Create A new Session in the database and return the ID
                SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["HOYALensConn"].ConnectionString);

                sqlConnection.Open();

                string sqlText = "INSERT INTO USERS (SESSIONID, dtCreated) VALUES (@SessionId, @dtCreated)";

                SqlParameter sqlParameters = new SqlParameter();

                SqlCommand sqlCommand = new SqlCommand(sqlText, sqlConnection);

                sqlCommand.Parameters.Add("@SessionId", SqlDbType.UniqueIdentifier).Value = newGuid;
                sqlCommand.Parameters.Add("@dtCreated", SqlDbType.DateTime).Value = DateTime.Now;

                int RowCount = sqlCommand.ExecuteNonQuery();

                if (RowCount > 0)
                {
                    cgiResponse = newGuid.ToString();
                }
                else
                {
                    cgiResponse = "0";
                }

                sqlConnection.Close();

                //Create Session Cookie, to be used by Coupon app later
                Response.Cookies.Add(new HttpCookie("SessionId", newGuid.ToString()));
            }
            catch (Exception ex)
            {
                // Any sort of error is going to be sql permissions or database down,
                // so don't really care what happened, just have to tell Mark about it
                cgiResponse = "0";
            }

            Response.Write(cgiResponse);
        }
    }

