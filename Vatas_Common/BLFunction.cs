using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;

namespace Vatas_Common
{
    public sealed class BLFunction
    {
        private static readonly BLFunction instance = new BLFunction();

        // Explicit static constructor to tell C# compiler
        // not to mark type as beforefieldinit
        static BLFunction()
        {
        }

        private BLFunction()
        {
        }

        //public static BLFunction Instance
        //{
        //    get
        //    {
        //        return instance;
        //    }
        //}

        //Get the Current Page Relative Path
        public static string BaseUrl()
        {
            string path = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + HttpContext.Current.Request.ApplicationPath;
            return path.EndsWith("/") ? path : path + "/";
        }

        /// <summary>
        /// Get Current ClientIP
        /// </summary>
        /// <returns></returns>
        public static string ClientIP()
        {
            string clientIp = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (!string.IsNullOrEmpty(clientIp))
            {
                string[] forwardedIps = clientIp.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                clientIp = forwardedIps[forwardedIps.Length - 1];
            }
            else
            {
                clientIp = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
            }

            return clientIp;
        }

        /// <summary>
        /// Get Current UserID
        /// </summary>
        /// <returns></returns>
        public static int GetUserID()
        {
            HttpContext context = HttpContext.Current;

            if (context.User.Identity.IsAuthenticated)
            {
                string decrypt = BLSecurity.Decrypt(context.User.Identity.Name);
                string[] temp = decrypt.Split('$');

                int user_id = 0;

                int.TryParse(temp[0].ToString(), out user_id);

                return user_id;
            }
            else
            {
                return 0;
            }
        }

        /// <summary>
        /// Get Current User Name
        /// </summary>
        /// <returns></returns>
        public static string GetUserName()
        {
            HttpContext context = HttpContext.Current;
            if (context.User.Identity.IsAuthenticated)
            {
                string decrypt = BLSecurity.Decrypt(context.User.Identity.Name);
                string[] temp = decrypt.Split('$');

                if (temp.Count() > 0)
                {
                    return temp[1];
                }
            }
            return "Guest";
        }

        /// <summary>
        /// Get Current RoleName
        /// </summary>
        /// <returns></returns>
        public static string GetRoleName()
        {
            HttpContext context = HttpContext.Current;

            if (context.User.Identity.IsAuthenticated)
            {
                string decrypt = BLSecurity.Decrypt(context.User.Identity.Name);
                string[] temp = decrypt.Split('$');

                return temp[2].ToString();
            }
            else
            {
                return "";
            }
        }

        /// <summary>
        /// Show Alert Message
        /// </summary>
        /// <param name="page"></param>
        /// <param name="message"></param>
        /// <param name="type"></param>
        public static void ShowAlert(Control page, string message, ResponseType type = ResponseType.PRIMARY)
        {
            //ScriptManager.RegisterClientScriptBlock(page, typeof(Page), Guid.NewGuid().ToString(), "ShowAlert('" + type.ToString() + "','" + message.Replace("'", "").Replace("\r\n", "<Br/>") + "')", true);
            ScriptManager.RegisterStartupScript(page, typeof(Page), Guid.NewGuid().ToString(), "ShowAlert('" + type.ToString() + "','" + message.Replace("'", "").Replace("\r\n", "<Br/>") + "')", true);
            return;
        }

        /// <summary>
        /// Show Alert With Message
        /// </summary>
        /// <param name="page"></param>
        /// <param name="message"></param>
        /// <param name="pageurl"></param>
        /// <param name="type"></param>
        public static void ShowAlertRedirect(Control page, string message, string pageurl, ResponseType type = ResponseType.PRIMARY)
        {
            ScriptManager.RegisterStartupScript(page, typeof(Page), Guid.NewGuid().ToString(), "ShowMessageWithPageRedirect('" + type.ToString() + "','" + message.Replace("'", "").Replace("\r\n", "<Br/>") + "','" + pageurl + "')", true);
            return;
        }
    }
}
