using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Vatas_Common;

namespace Vatas_UI.Associate
{
    public partial class ViewUsers : VatasWebPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (BLFunction.GetRoleName().ToLower() != "associate")
                {
                    Response.RedirectToRoute("401");
                }
            }
        }

        protected void ddlPageLength_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}