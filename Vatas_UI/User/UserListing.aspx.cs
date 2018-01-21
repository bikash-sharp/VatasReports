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
            if (!Page.IsPostBack)
            {
                BindData();
            }
        }

        public string AppPath()
        {
            string path = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + HttpContext.Current.Request.ApplicationPath;
            return path.EndsWith("/") ? path : path + "/";
        }

        public void BindData()
        {
            List<UserRegistrationCL> result = DataProviderWrapper.Instance.GetAllRegisterdUser();
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
            Button btnEditUser = (Button)(sender);
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
                Button btnDeleteUser = (Button)(sender);
                int UserId = Convert.ToInt32(btnDeleteUser.CommandArgument);

                bool IsSaved = DataProviderWrapper.Instance.DeleteRegisteredUser(UserId);
                if (IsSaved)
                {
                    BLFunction.ShowAlert(this, "User has been deleted Successfully.", ResponseType.SUCCESS);
                    BindData();
                }
                else
                {
                    BLFunction.ShowAlert(this, "Unable to deletethe user.", ResponseType.WARNING);
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }
    }
}