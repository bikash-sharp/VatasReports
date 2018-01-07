using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Vatas_UI
{
    public partial class Root : VatasMasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hfPath.Value = AppPath();
            if (!this.Page.User.Identity.IsAuthenticated)
            {
                HttpContext.Current.Response.RedirectToRoute("Login");
                return;
            }
        }

        protected void lnkLogOut_Click(object sender, EventArgs e)
        {
            HttpContext.Current.Session.Abandon();
            FormsAuthentication.SignOut();
            HttpContext.Current.Response.AddHeader("Cache-Control", "no-cache, no-store, max-age=0, must-revalidate");
            HttpContext.Current.Response.AddHeader("Pragma", "no-cache");
            HttpContext.Current.Response.RedirectToRoute("Login");
        }
    }
}