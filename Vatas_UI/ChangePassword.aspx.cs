using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Vatas_Common;
using Vatas_Wrapper;

namespace Vatas_UI
{
    public partial class ChangePassword : VatasWebPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Clear();
        }

        public void Clear()
        {
            txtOldPassword.Text = string.Empty;
            txtConfirmPassword.Text = string.Empty;
            txtPassword.Text = string.Empty;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                string OldPassword = txtOldPassword.Text.Trim();
                string Password = txtPassword.Text.Trim();
                string ConfirmPassword = txtConfirmPassword.Text.Trim();
                string EmailId = BLFunction.GetUserName();

                bool IsOldPasswordVaild = DataProviderWrapper.Instance.IsOldPasswordVaild(EmailId, OldPassword);

                if (IsOldPasswordVaild)
                {
                    bool IsSaved = DataProviderWrapper.Instance.UpdateNewPassword(EmailId, Password);
                    if (IsSaved)
                    {
                        Clear();
                        BLFunction.ShowAlertRedirect(this, "Password has been successfully updated.", CurrentPagePath + "UserListing", ResponseType.SUCCESS);
                    }
                    else
                    {
                        BLFunction.ShowAlert(this, "Unable to update password.", ResponseType.WARNING);
                    }
                }
                else
                {
                    BLFunction.ShowAlert(this, "Please enter the valid Old password.", ResponseType.SUCCESS);
                }
            }
            catch (Exception ex)
            {
                BLFunction.ShowAlert(this, "Server Error Occurred.", ResponseType.DANGER);
            }
        }
    }
}