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
        protected void Page_Load(object sender, EventArgs e)
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
                Session.Abandon();
                FormsAuthentication.SignOut();
            }
            txtPassword.Focus();

        }

        protected void lnkLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                var loginResult = DataProviderWrapper.Instance.CheckUserCredentials(hfUserName.Value, txtPassword.Text.Trim());
                if (loginResult.Resp == ResponseType.SUCCESS)
                {
                    string userData = loginResult.UserID + "$" + loginResult.UserName;

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
                    Response.RedirectToRoute("Report");
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