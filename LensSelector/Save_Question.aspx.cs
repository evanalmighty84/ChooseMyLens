using System;
using System.Collections;
using System.Collections.Generic;
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


    public partial class Save_Question : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string cgiResponse = "";

            try
            {
                // Create A new Session in the database and return the ID
                SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["HOYALensConn"].ConnectionString);

                string sqlText = string.Empty;

                sqlConnection.Open();

                #region Extract Questions and put in sql string
                for (int z = 1; z <= 19; z++)
                {
                    if (Request.QueryString[string.Format("Question{0}", z)] != null && Request.QueryString[string.Format("Question{0}", z)].Length > 0)
                    {
                        if (sqlText.Length > 0)
                        {
                            sqlText += ", ";
                        }

                        sqlText += string.Format("Question_{0:0#} = @Answer_{0:0#}", z);
                    }
                }

                sqlText += " WHERE SessionId = @SessionId";
                sqlText = "UPDATE Users SET " + sqlText;

                SqlCommand sqlCommand = new SqlCommand(sqlText, sqlConnection);
                #endregion

                #region Replace the parameters in the new command string
                for (int z = 1; z <= 19; z++)
                {
                    if (Request.QueryString[string.Format("Question{0}", z)] != null && Request.QueryString[string.Format("Question{0}", z)].Length > 0)
                    {
                        SqlParameter sp = new SqlParameter(string.Format("@Answer_{0:0#}", z),Request.QueryString[string.Format("Question{0}", z)]);
                        sqlCommand.Parameters.Add(sp);
                        //if (z != 16)
                        //{
                        //    sqlCommand.Parameters.Add(, SqlDbType.NVarChar).Value = ;
                        //}
                        //else
                        //{
                        //    sqlCommand.Parameters.Add(string.Format("@Answer_{0:0#}", z), SqlDbType.NText).Value = Request.QueryString[string.Format("Question{0}", z)];
                        //}
                    }
                }
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


/*
SessionId
EmailAddress
PostalCode
Question_01
Question_02
Question_03
Question_04
Question_05
Question_06
Question_07
Question_08
Question_09
Question_10
Question_11
Question_12
Question_13
Question_14
Question_15
SessionCompleted
dtCreated
dtCompleted
*/