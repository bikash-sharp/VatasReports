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
    public partial class EditUser : System.Web.UI.Page
    {
        HttpContext CurrContext = HttpContext.Current;
        static int UserId = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
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

                if (BLFunction.GetRoleName().ToLower() == "superadmin")
                {
                    txtPassword.Attributes.Add("value", result.Password);
                    txtConfirmPassword.Attributes.Add("value", result.Password);
                    //txtPassword.Text = result.Password;
                    //txtConfirmPassword.Text = result.Password;
                }
                else
                {
                    txtPassword.Text = string.Empty;
                    txtConfirmPassword.Text = string.Empty;
                }


                txtMobileNumber.Text = result.MobileNumber;
                if (result.RoleId > 0)
                    ddlRoles.SelectedValue = result.RoleId.ToString();
            }
        }

        //BLFunction.GetRoleName() == "Admin"

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                UserRegistrationCL createUser = new UserRegistrationCL();
                createUser.UserId = UserId;
                createUser.FirstName = txtFirstName.Text;
                createUser.LastName = txtLastName.Text;
                createUser.Email = txtEmail.Text;
                createUser.Password = txtPassword.Text;
                createUser.MobileNumber = txtMobileNumber.Text;
                createUser.AccountType = ddlAccountType.SelectedValue;
                createUser.RoleId = Convert.ToInt32(ddlRoles.SelectedValue);

                bool IsSaved = DataProviderWrapper.Instance.AddUpdateUser(createUser);
                if (IsSaved)
                {
                    BLFunction.ShowAlert(this, "User has been updated successfully", ResponseType.SUCCESS);
                    Server.Transfer("UserListing.aspx");
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
            Server.Transfer("UserListing.aspx");
            //Response.Redirect("UserListing.aspx");
        }
    }
}