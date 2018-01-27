using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Vatas_Common;
using Vatas_Wrapper;

namespace Vatas_UI.User
{
    public partial class EditUser : VatasWebPage
    {
        HttpContext CurrContext = HttpContext.Current;
        static int UserId = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (BLFunction.GetRoleName().ToLower() == "superadmin")
                {
                    try
                    {
                        UserId = Convert.ToInt32(CurrContext.Items["UserId"].ToString());
                        //int UserId = Convert.ToInt32(Request.QueryString["UserId"].ToString());
                        BindRoles();
                        BindData(UserId);
                    }
                    catch (Exception ex)
                    {
                        Server.Transfer("UserListing.aspx");
                    }
                }
                else
                {
                    Response.RedirectToRoute("401");
                }
            }
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
        public void BindData(int UserId)
        {
            UserRegistrationCL result = DataProviderWrapper.Instance.GetRegisterdUserByUserId(UserId);
            if (result != null)
            {
                txtFirstName.Text = result.FirstName;
                txtLastName.Text = result.LastName;
                txtEmail.Text = result.Email;
                hfPassword.Value = result.Password;
                txtPassword.Attributes.Add("value", result.Password);
                txtConfirmPassword.Attributes.Add("value", result.Password);
                txtMobileNumber.Text = result.MobileNumber;
                if (result.RoleId > 0)
                    ddlRoles.SelectedValue = result.RoleId.ToString();
                chkIsEnabled.Checked = ((String.IsNullOrEmpty(result.IsActive) || result.IsActive != "Y") ? false : true);
            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                UserRegistrationCL createUser = new UserRegistrationCL();
                createUser.UserId = UserId;
                createUser.FirstName = txtFirstName.Text;
                createUser.LastName = txtLastName.Text;
                createUser.Email = txtEmail.Text;
                if (BLFunction.GetRoleName().ToLower() != "superadmin")
                    createUser.Password = hfPassword.Value;
                else
                    createUser.Password = txtPassword.Text;
                createUser.MobileNumber = txtMobileNumber.Text;
                createUser.AccountType = ddlAccountType.SelectedValue;
                createUser.RoleId = Convert.ToInt32(ddlRoles.SelectedValue);

                createUser.IsActive = chkIsEnabled.Checked ? "Y" : "N";

                bool IsSaved = DataProviderWrapper.Instance.AddUpdateUser(createUser);
                if (IsSaved)
                {
                    BLFunction.ShowAlertRedirect(this, "User has been updated successfully", CurrentPagePath + "UserListing", ResponseType.SUCCESS);
                }
                else
                {
                    BLFunction.ShowAlert(this, "Unable to update the user details.", ResponseType.WARNING);
                }

            }
            catch (Exception ex)
            {
                BLFunction.ShowAlert(this, "Server Error Occurred.", ResponseType.DANGER);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.RedirectToRoute(CurrentPagePath + "UserListing");
            //Server.Transfer("UserListing.aspx");
        }
    }
}