using System;
using System.Collections.Generic;
using System.Linq;
using Vatas_Common;
using Vatas_Wrapper;

namespace Vatas_UI.Home
{
    public partial class Index : VatasWebPage
    {
        public Int32 RecordCount = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            int PageNumber = 1;
            int.TryParse(hidPageNo.Value, out PageNumber);

            int PageSize = 10;
            if (BLFunction.GetRoleName().ToLower() == "potentialuser")
            {
                int.TryParse(ddlPUPageLength.SelectedValue, out PageSize);
            }
            else if (BLFunction.GetRoleName().ToLower() == "superadmin" || BLFunction.GetRoleName().ToLower() == "admin" || BLFunction.GetRoleName().ToLower() == "dataentrysupervisor" || BLFunction.GetRoleName().ToLower() == "frontofficesupervisor")
            {
                int.TryParse(ddlAPageLength.SelectedValue, out PageSize);
            }
            if (PageSize <= 0)
            {
                PageSize = RecordCount;
            }
            if (!IsPostBack)
            {
                if (BLFunction.GetRoleName().ToLower() == "potentialuser")
                {
                    
                    BindUserReports(BLFunction.GetUserID(), PageNumber, PageSize, "");
                }
                else if (BLFunction.GetRoleName().ToLower() == "superadmin" || BLFunction.GetRoleName().ToLower() == "admin" || BLFunction.GetRoleName().ToLower() == "dataentrysupervisor" || BLFunction.GetRoleName().ToLower() == "frontofficesupervisor")
                {
                    BindDocuments(PageNumber, PageSize);
                }
            }
        }

        #region Potential User
        public void BindUserReports(int UserID, int PageNumber, int PageSize, string SearchText)
        {
            int TotalPages = 0;
            List<UserDocumentDetailedWrapper> result = DataProviderWrapper.Instance.GetDocumentByUserId(UserID, PageNumber, PageSize, SearchText);
            rptPotentialUser.DataSource = null;
            if (result.Count > 0)
            {
                rptPotentialUser.DataSource = result;
                int.TryParse(result.FirstOrDefault()?.RecordCount + "", out TotalPages);
            }
            rptPotentialUser.DataBind();
            RecordCount = TotalPages;
            float pages = Convert.ToSingle(TotalPages) / Convert.ToSingle(PageSize);
            TotalPages = Convert.ToInt32(Math.Ceiling(pages));
            hidPages.Value = TotalPages.ToString();
        }

        protected void btnPUSearch_Click(object sender, EventArgs e)
        {

        }

        protected void ddlPUPageLength_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnUploadDocument_Click(object sender, EventArgs e)
        {

        }

        #endregion



        public void BindDocuments(int PageNumber, int PageSize)
        {
            int TotalPages = 0;
            List<AssociateUserDocumentsCL> result = DataProviderWrapper.Instance.GetAllUserDocuments(chkIsActive.Checked, PageNumber, PageSize);
            rptAdmin.DataSource = null;
            if (result.Count > 0)
            {
                rptAdmin.DataSource = result;
                int.TryParse(result.FirstOrDefault()?.RecordCount + "", out TotalPages);
            }
            rptAdmin.DataBind();
            RecordCount = TotalPages;
            float pages = Convert.ToSingle(TotalPages) / Convert.ToSingle(PageSize);
            TotalPages = Convert.ToInt32(Math.Ceiling(pages));
            hidPages.Value = TotalPages.ToString();
        }


        protected void chkIsActive_CheckedChanged(object sender, EventArgs e)
        {
            int PageNumber = 1;
            int.TryParse(hidPageNo.Value, out PageNumber);

            int PageSize = 10;
            int.TryParse(ddlAPageLength.SelectedValue, out PageSize);
            if (PageSize <= 0)
            {
                PageSize = RecordCount;
            }
            BindDocuments(PageNumber, PageSize);
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            BLFunction.ShowAlertRedirect(this, "Document has been assigned to respective users", CurrentPagePath + "Index", ResponseType.SUCCESS);
        }



        protected void ddlAPageLength_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        
    }
}