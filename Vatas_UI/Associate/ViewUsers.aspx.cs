using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Vatas_Common;
using Vatas_Wrapper;

namespace Vatas_UI.Associate
{
    public partial class ViewUsers : VatasWebPage
    {
        public Int32 RecordCount = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            int PageNumber = 1;
            int.TryParse(hidPageNo.Value, out PageNumber);

            int PageSize = 10;
            int.TryParse(ddlPageLength.SelectedValue, out PageSize);
            if (PageSize <= 0)
            {
                PageSize = RecordCount;
            }
            if (!IsPostBack)
            {
                if (BLFunction.GetRoleName().ToLower() != "associate")
                {
                    Response.RedirectToRoute("401");
                }
                else
                {
                    BindReports(BLFunction.GetUserID(), PageNumber, PageSize);
                }
            }
        }

        public void BindReports(int UserID, int PageNumber, int PageSize)
        {
            int TotalPages = 0;
            List<AssociateUserCL> result = DataProviderWrapper.Instance.GetUsersByAssociateId(UserID, PageNumber, PageSize,"");
            rptProcess.DataSource = null;
            if (result.Count > 0)
            {
                rptProcess.DataSource = result;
                int.TryParse(result.FirstOrDefault()?.RecordCount + "", out TotalPages);
            }
            rptProcess.DataBind();
            RecordCount = TotalPages;
            float pages = Convert.ToSingle(TotalPages) / Convert.ToSingle(PageSize);
            TotalPages = Convert.ToInt32(Math.Ceiling(pages));
            hidPages.Value = TotalPages.ToString();
        }

        protected void ddlPageLength_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}