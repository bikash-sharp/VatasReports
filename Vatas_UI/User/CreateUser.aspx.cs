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
    public partial class CreateUser : VatasWebPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (BLFunction.GetRoleName().ToLower() == "superadmin")
                {
                    BindRoles();
                }
                else
                {
                    Response.RedirectToRoute("401");
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                UserRegistrationCL createUser = new UserRegistrationCL();
                createUser.UserId = 0;
                createUser.FirstName = txtFirstName.Text;
                createUser.LastName = txtLastName.Text;
                createUser.Email = txtEmail.Text;
                createUser.Password = txtPassword.Text;
                createUser.MobileNumber = txtMobileNumber.Text;
                createUser.AccountType = ddlAccountType.SelectedValue;
                createUser.RoleId = int.Parse(ddlRoles.SelectedValue);
                createUser.IsActive = "Y";

                bool IsExist = DataProviderWrapper.Instance.IsEmailExist(createUser.Email);

                if (!IsExist)
                {
                    bool IsSaved = DataProviderWrapper.Instance.AddUpdateUser(createUser);
                    if (IsSaved)
                    {
                        Clear();
                        BLFunction.ShowAlertRedirect(this, "New User Created Successfully", CurrentPagePath+"UserListing", ResponseType.SUCCESS);
                    }
                    else
                    {
                        BLFunction.ShowAlert(this, "Unable To Create a New User.", ResponseType.WARNING);
                    }
                }
                else
                {
                    BLFunction.ShowAlert(this, "EmailId already exist.", ResponseType.SUCCESS);
                }
            }
            catch (Exception ex)
            {
                BLFunction.ShowAlert(this, "Server Error Occurred.", ResponseType.DANGER);
            }
        }

        public void Clear()
        {
            txtFirstName.Text = string.Empty;
            txtLastName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtPassword.Text = string.Empty;
            txtMobileNumber.Text = string.Empty;
        }

        public void BindRoles()
        {
            List<DropDownCL> roles = DataProviderWrapper.Instance.GetAllRoles();
            ddlRoles.DataSource = null;
            if (roles.Count > 0)
            {
                ddlRoles.DataSource = roles;
                ddlRoles.DataTextField = "DataText";
                ddlRoles.DataValueField = "DataValue";
            }
            ddlRoles.DataBind();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Clear();
        }
    }
}