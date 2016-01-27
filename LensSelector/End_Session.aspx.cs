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


    public partial class End_Session : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string cgiResponse = "";

            try
            {
                // Create A new Session in the database and return the ID
                SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["HoyaLensConn"].ConnectionString);

                sqlConnection.Open();

                string sqlText = string.Empty;
                
                #region Extract Questions and put in sql string
                sqlText = "UPDATE USERS SET EmailAddress = @EmailAddress, ";
                sqlText += "PostalCode = @PostalCode, ";
                sqlText += "SessionCompleted = '1', ";
                sqlText += "dtCompleted = '" + DateTime.Now + "' ";
                sqlText += " WHERE SessionId = @SessionId";

                SqlCommand sqlCommand = new SqlCommand(sqlText, sqlConnection);

                sqlCommand.Parameters.AddWithValue("@EmailAddress", Request.QueryString["email"]);
                sqlCommand.Parameters.AddWithValue("@PostalCode", Request.QueryString["ZipCode"]);
                sqlCommand.Parameters.AddWithValue("@SessionId", Request.QueryString["SessionId"]);
                #endregion

                int RowCount = sqlCommand.ExecuteNonQuery();

                if (RowCount > 0)
                {
                    cgiResponse = "ErrorCode=0";
                }
                else
                {
                    cgiResponse = "ErrorCode=1";
                }

                sqlConnection.Close();
            }
            catch (Exception ex)
            {
                // Any sort of error is going to be sql permissions or database down,
                // so don't really care what happened, just have to tell Mark about it
                cgiResponse = "ErrorCode=2";
            }

            Response.Write(cgiResponse);
        }
    }

