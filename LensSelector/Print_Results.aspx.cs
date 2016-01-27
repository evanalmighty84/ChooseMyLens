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

namespace LensSelector
{
    public partial class Print_Results : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int ProviderId = 0;
            #region Create Sql Connection

            SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["HOYALensConn"].ConnectionString);

            sqlConnection.Open();

            string sqlText = string.Empty;
            #endregion

            #region Grab the session ID and query for this user in the database
            sqlText = "SELECT * FROM Users";
            sqlText += " WHERE SessionId = @SessionId";

            SqlCommand sqlCommand = new SqlCommand(sqlText, sqlConnection);

            sqlCommand.Parameters.AddWithValue("@SessionId", Request.QueryString["SessionId"]);
            #endregion

            SqlDataReader sqlDataReader = sqlCommand.ExecuteReader();

            if (sqlDataReader.Read())
            {
                #region Grab the data I care About
                string ZipCode = sqlDataReader["Question_03"].ToString();
                string RawProviderList = sqlDataReader["Question_16"].ToString();
                string TintType = sqlDataReader["Question_14"].ToString();
                string TintColor = sqlDataReader["Question_15"].ToString();
                ProviderId = int.Parse(sqlDataReader["Question_17"].ToString());

                //@@@@@ Testing 3 columns
                //                    RawProviderList = "NULUX EP,Single Vision,Phoenix,Polorized,Anti-Reflective,Scratch Resistant, Photchromic,View Protect|LIFESTYLE,Progressive: Lifestyle,1.7,Polorized,Anti-Reflective,Scratch Resistant, Photchromic,View Protect|NULUX,Single Vision: Nulux,1.67,Polorized,Anti-Reflective,Scratch Resistant, Photchromic,View Protect";

                //@@@@@ Testing 2 columns
                //                    RawProviderList = "NULUX EP,Single Vision,Phoenix,Polorized,Anti-Reflective,Scratch Resistant, Photchromic,View Protect|NULUX,Single Vision: Nulux,1.67,Polorized,Anti-Reflective,Scratch Resistant, Photchromic,View Protect";

                string[] Sections = RawProviderList.Split('|');
                bool HasComplementary = false;

                // If there is 3 sections, then there is complementary data
                if (Sections.Length == 3)
                {
                    HasComplementary = true;
                }
                else
                {
                    pnlComplementary.Visible = false;
                }

                int Index = 0;
                foreach (string Section in Sections)
                {
                    string[] Results = Section.Split(',');

                    #region switch on Index in results
                    switch (Index)
                    {
                        case 0: // Primary should always exists
                            lblPrimaryTitle.Text = Results[0];
                            lblPrimaryDesign.Text = Results[1];
                            lblPrimaryMaterials.Text = Results[2];

                            lblPrimaryTreatment.Text = string.Empty;
                            for (int z = 3; z < Results.Length; z++)
                            {
                                lblPrimaryTreatment.Text += Results[z] + "<br />";
                            }
                            break;
                        case 1: // Might be Complementary or Speciality
                            if (HasComplementary)
                            {
                                lblComplementaryTitle.Text = Results[0];
                                lblComplementaryDesign.Text = Results[1];
                                lblComplementaryMaterials.Text = Results[2];

                                lblComplementaryTreatment.Text = string.Empty;
                                for (int z = 3; z < Results.Length; z++)
                                {
                                    lblComplementaryTreatment.Text += Results[z] + "<br />";
                                }
                            }
                            else
                            {
                                lblSpecialityTitle.Text = Results[0];
                                lblSpecialityDesign.Text = Results[1];
                                lblSpecialityMaterials.Text = Results[2];

                                lblSpecialityTreatment.Text = string.Empty;
                                for (int z = 3; z < Results.Length; z++)
                                {
                                    lblSpecialityTreatment.Text += Results[z] + "<br />";
                                }
                            }
                            break;
                        case 2: // Had complementary now fill in speciality
                            lblSpecialityTitle.Text = Results[0];
                            lblSpecialityDesign.Text = Results[1];
                            lblSpecialityMaterials.Text = Results[2];

                            lblSpecialityTreatment.Text = string.Empty;
                            for (int z = 3; z < Results.Length; z++)
                            {
                                lblSpecialityTreatment.Text += Results[z] + "<br />";
                            }
                            break;
                    }
                    #endregion end switch

                    // Increment the index
                    Index++;
                }

                #region Fill in the special values from user questions
                lblTintType.Text = TintType;
                lblTintColor.Text = TintColor;
                #endregion

                #endregion
            }
            else
            {
                // Send back some sort of Error?
            }

            #region Grab the Provider Information
            sqlDataReader.Close();
            sqlCommand = new SqlCommand("usp_getProviderById", sqlConnection);
            sqlCommand.CommandType = CommandType.StoredProcedure;

            sqlCommand.Parameters.AddWithValue("@Pid", ProviderId);

            sqlDataReader = sqlCommand.ExecuteReader();

            if (sqlDataReader.Read())
            {
                // Available columns
                // location_id, zipcode, store, address, city, state, phone, store_num, longitude, latitude, Certified, lattemp, longtemp
                // has at least one row
                lblProviderTitle.Text = sqlDataReader["store"].ToString();
                lblProviderAddressLine1.Text = string.Format("{0}", sqlDataReader["address"].ToString());
                lblProviderAddressLine2.Text = string.Format("{0}  {1}  {2}",
                    sqlDataReader["city"].ToString(),
                    sqlDataReader["state"].ToString(),
                    sqlDataReader["zipcode"].ToString());

                lblProviderPhone.Text = sqlDataReader["phone"].ToString();
            }
            #endregion

            sqlConnection.Close();
            //}
            //catch (Exception ex)
            //{
            //    // Any sort of error is going to be sql permissions or database down,
            //    // so don't really care what happened, just have to tell Mark about it
            //    Response.Write("What do you want me to do on error");
            //}
        }
    }
}