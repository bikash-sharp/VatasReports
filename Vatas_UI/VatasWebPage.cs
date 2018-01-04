using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Vatas_Common;

namespace Vatas_UI
{
    public class VatasWebPage : System.Web.UI.Page
    {
        protected override void OnUnload(EventArgs e)
        {
            if (!this.Page.User.Identity.IsAuthenticated)
            {
                HttpContext.Current.Response.RedirectToRoute("Login");
                return;
            }
            base.OnUnload(e);
        }

        public int CurrentUserID
        {
            get
            {
                return BLFunction.GetUserID();
            }
        }

        public string CurrentUserName
        {
            get
            {
                return BLFunction.GetUserName();
            }
        }

        public string CurrentRoleName
        {
            get
            {
                return BLFunction.GetRoleName();
            }
        }

        public string CurrentPagePath
        {
            get
            {
                return BLFunction.BaseUrl();
            }
        }
        /// <summary>
        /// get Current Base Directory of the page
        /// </summary>
        public string CurrentBaseDirectoryPath
        {
            get
            {
                string BaseUrl = CurrentPagePath;
                if ((this.Page.Master as SiteAdmin) == null)
                {
                    BaseUrl += @"Admin/";
                }
                else
                {
                    BaseUrl += @"User/";
                }

                return BaseUrl;
            }
        }

        
    }
}