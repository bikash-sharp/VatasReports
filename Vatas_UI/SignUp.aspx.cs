using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Vatas_Common;

namespace Vatas_UI
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
                if (this.Request.IsAuthenticated)
                {
                    String roleTypeName = BLFunction.GetRoleName();
                    if (roleTypeName.ToLower().Contains("admin"))
                    {
                        Response.Redirect("AdminHome", true);
                    }
                    else
                    {
                        Response.Redirect("UserHome", true);
                    }
                }
        }

        //Get the Current Page Relative Path
        public string AppPath()
        {
            string path = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + HttpContext.Current.Request.ApplicationPath;
            return path.EndsWith("/") ? path : path + "/";
        }
    }
}