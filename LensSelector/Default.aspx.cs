using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Get a clientScript instance from the Page
        ClientScriptManager csm = Page.ClientScript;

        // Check if Script is already registred.
        // If not, register as StartupScript.
        if (!csm.IsStartupScriptRegistered("swfScript"))
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("var so = new SWFObject(\"hoyaLoader.swf\", \"flashPiece\", \"960\", \"660\", \"10,0,0\", \"#000000\");");

            if (Request.Cookies["lid"] != null)
            {
                sb.Append("so.addVariable(\"lid\", \"").Append(Request.Cookies["lid"].Value).Append("\");");
            }
            else if (Request.Cookies["gid"] != null)
            {
                sb.Append("so.addVariable(\"gid\", \"").Append(Request.Cookies["gid"].Value).Append("\");");
            }
            
            //if (Request.Cookies["UserID"] != null)
            //{
            //    sb.Append("so.addVariable(\"ShowCoupon\", \"True\");");
            //}

            sb.Append("so.addParam(\"allowScriptAccess\", \"always\");");
            sb.Append("so.write(\"flash\");");
            csm.RegisterStartupScript(typeof(Page), "swfScript",
                    sb.ToString(),
                    true);
        }
    }
}
