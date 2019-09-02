using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using Vatas_Common;
using Vatas_Wrapper;

namespace Vatas_UI.Associate
{
    public partial class CreateUser : VatasWebPage
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

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                int UserAssociateId = 0;
                UserAssociateId = DataProviderWrapper.Instance.SaveAssociateUser(0, BLFunction.GetUserID(), txtFirstName.Text.Trim(), txtLastName.Text.Trim(), txtEmail.Text.Trim(), txtMobileNumber.Text.Trim(), null);
                if (UserAssociateId > 0)
                {
                    BLFunction.ShowAlertRedirect(this, "User Creation success", CurrentPagePath + "NewUser", ResponseType.SUCCESS);
                }
                else
                {
                    BLFunction.ShowAlert(this, "User Creation failed.Please try later.", ResponseType.WARNING);
                }
            }
            catch (Exception)
            {
                BLFunction.ShowAlert(this, "Server Error Occurred.", ResponseType.DANGER);
            }
        }
    }
}