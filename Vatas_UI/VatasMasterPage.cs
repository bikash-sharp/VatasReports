using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Vatas_UI
{
    public class VatasMasterPage : System.Web.UI.MasterPage
    {

        //Get the Current Page Relative Path
        public string AppPath()
        {
            string path = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + HttpContext.Current.Request.ApplicationPath;
            return path.EndsWith("/") ? path : path + "/";
        }

    }
}