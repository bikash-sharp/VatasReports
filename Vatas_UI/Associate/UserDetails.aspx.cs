using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Vatas_Common;
using Vatas_Wrapper;

namespace Vatas_UI.Associate
{
    public partial class UserDetails : VatasWebPage
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
                var strId = Convert.ToString(Page.RouteData.Values["Id"]);
                long AssociaterUserId = 0;
                long.TryParse(strId, out AssociaterUserId);
                if (BLFunction.GetRoleName().ToLower() != "associate" || AssociaterUserId == 0)
                {
                    Response.RedirectToRoute("401");
                }
                else
                {
                    BindUserDetails(AssociaterUserId);
                    BindUserDocument(AssociaterUserId, PageNumber, PageSize, "");
                }
            }
        }

        public void BindUserDetails(long userId)
        {
            AssociateUserCL result = DataProviderWrapper.Instance.GetCustomerById(userId);
            if (result != null)
            {
                txtEmail.Text = result.EmailId;
                txtFirstName.Text = result.FirstName;
                txtLastName.Text = result.LastName;
                txtMobileNumber.Text = result.Contact;
            }
        }

        protected void ddlPageLength_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            var strId = Convert.ToString(Page.RouteData.Values["Id"]);
            int AssociaterUserId = 0;
            int.TryParse(strId, out AssociaterUserId);
            var Id = DataProviderWrapper.Instance.SaveAssociateUser(AssociaterUserId, BLFunction.GetUserID(), txtFirstName.Text.Trim(), txtLastName.Text.Trim(), txtEmail.Text.Trim(), txtMobileNumber.Text.Trim(), DateTime.Now);
            if (Id > 0)
            {
                BLFunction.ShowAlert(this, "User details has been updated.", ResponseType.SUCCESS);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }

        public void BindUserDocument(long UserID, int PageNumber, int PageSize, string SearchText)
        {
            int TotalPages = 0;
            List<UserDocumentDetailedWrapper> result = DataProviderWrapper.Instance.GetDocumentByUserId(UserID, PageNumber, PageSize, SearchText,true);
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
        protected void btnUploadDocument_Click(object sender, EventArgs e)
        {
            HttpContext _context = HttpContext.Current;
            var strId = Convert.ToString(Page.RouteData.Values["Id"]);
            int AssociaterUserId = 0;
            int.TryParse(strId, out AssociaterUserId);
            _context.Items.Add("CustomerId", AssociaterUserId);

            Server.Transfer("~/User/UserForm.aspx");
        }
    }
}