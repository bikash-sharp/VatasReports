using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Vatas_Common;
using Vatas_Wrapper;

namespace Vatas_UI.User
{
    public partial class UserListing : VatasWebPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string isActive = "N";
            if (chkIsActive.Checked)
                isActive = "Y";
            if (!Page.IsPostBack)
            {
                BindData(isActive);
            }
        }

        public string AppPath()
        {
            string path = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + HttpContext.Current.Request.ApplicationPath;
            return path.EndsWith("/") ? path : path + "/";
        }

        public void BindData(string isActive)
        {
            List<UserRegistrationCL> result = DataProviderWrapper.Instance.GetAllRegisterdUser(isActive);
            if (result.Count > 0)
            {
                rptUserListing.DataSource = result;
                rptUserListing.DataBind();
            }
        }

        //protected void btnUserDetail_Click(object sender, EventArgs e)
        //{
        //    Button btnUserDetail = (Button)(sender);
        //    int UserId = Convert.ToInt32(btnUserDetail.CommandArgument);
        //}

        protected void btnEditUser_Click(object sender, EventArgs e)
        {
            LinkButton btnEditUser = (LinkButton)(sender);
            int UserId = Convert.ToInt32(btnEditUser.CommandArgument);

            HttpContext _context = HttpContext.Current;
            _context.Items.Add("UserId", UserId);

            Server.Transfer("~/User/EditUser.aspx");
            //Response.Redirect("EditUser.aspx?UserId=1");
        }

        protected void btnDeleteUser_Click(object sender, EventArgs e)
        {
            try
            {
                string isActive = "N";
                if (chkIsActive.Checked)
                    isActive = "Y";
                LinkButton btnDeleteUser = (LinkButton)(sender);
                int UserId = Convert.ToInt32(btnDeleteUser.CommandArgument);

                bool IsSaved = DataProviderWrapper.Instance.EnableDisableRegisteredUser(UserId,"N");
                if (IsSaved)
                {
                    BLFunction.ShowAlert(this, "User has been deleted successfully.", ResponseType.SUCCESS);
                    BindData(isActive);
                }
                else
                {
                    BLFunction.ShowAlert(this, "Unable to delete the user.", ResponseType.WARNING);
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        protected void chkIsActive_CheckedChanged(object sender, EventArgs e)
        {
            string isActive = "N";
            if (chkIsActive.Checked)
                isActive = "Y";
            BindData(isActive);
        }

        protected void btnEnableUser_Click(object sender, EventArgs e)
        {
            try
            {
                string isActive = "N";
                if (chkIsActive.Checked)
                    isActive = "Y";
                LinkButton btnEnableUser = (LinkButton)(sender);
                int UserId = Convert.ToInt32(btnEnableUser.CommandArgument);

                bool IsSaved = DataProviderWrapper.Instance.EnableDisableRegisteredUser(UserId,"Y");
                if (IsSaved)
                {
                    BLFunction.ShowAlert(this, "User has been enabled successfully.", ResponseType.SUCCESS);
                    BindData(isActive);
                }
                else
                {
                    BLFunction.ShowAlert(this, "Unable to enable the user.", ResponseType.WARNING);
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }
    }
}