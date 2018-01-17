using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Vatas_Common;
using Vatas_Wrapper;

namespace Vatas_UI
{
    public partial class LockScreen : System.Web.UI.Page
    {
        //Get the Current Page Relative Path
        public string AppPath()
        {
            string path = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + HttpContext.Current.Request.ApplicationPath;
            return path.EndsWith("/") ? path : path + "/";
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (!this.Page.User.Identity.IsAuthenticated)
                {
                    HttpContext.Current.Response.RedirectToRoute("Login");
                    return;
                }
                else
                {
                    lblUserName.Text = "User";
                    hfUserName.Value = BLFunction.GetUserName();
                    HttpContext.Current.Session.Abandon();
                    FormsAuthentication.SignOut();
                    HttpContext.Current.Response.AddHeader("Cache-Control", "no-cache, no-store, max-age=0, must-revalidate");
                    HttpContext.Current.Response.AddHeader("Pragma", "no-cache");
                }
                txtPassword.Focus();
            }
        }

        protected void lnkLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                var loginResult = DataProviderWrapper.Instance.CheckUserCredentials(hfUserName.Value, txtPassword.Text.Trim());
                if (loginResult.Resp == ResponseType.SUCCESS)
                {
                    string userData = loginResult.UserID + "$" + loginResult.UserName +"$"+loginResult.RoleName;

                    FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket(Convert.ToInt32(loginResult.UserID),
                        BLSecurity.Encrypt(userData),
                        DateTime.Now,
                        DateTime.Now.AddMinutes(2880),
                        false,
                        BLSecurity.Encrypt(userData),
                        FormsAuthentication.FormsCookiePath
                        );
                    string hash = FormsAuthentication.Encrypt(authTicket);
                    HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, hash);

                    if (authTicket.IsPersistent)
                    {
                        cookie.Expires = authTicket.Expiration;
                    }

                    Response.Cookies.Add(cookie);
                    Response.RedirectToRoute("Home");
                }
                else
                {
                    BLFunction.ShowAlert(this, loginResult.Message, loginResult.Resp);
                }
            }
            else
            {
                BLFunction.ShowAlert(this, "Invalid page request found. Reload again and try once again.", ResponseType.INFO);
            }
        }
    }
}