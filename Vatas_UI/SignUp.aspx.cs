using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Vatas_Common;
using Vatas_Wrapper;

namespace Vatas_UI
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
                if (this.Request.IsAuthenticated)
                {
                    String roleTypeName = BLFunction.GetRoleName();
                    if (roleTypeName.ToLower().Contains("admin"))
                    {
                        Response.Redirect("AdminHome", true);
                    }
                    else
                    {
                        Response.Redirect("UserHome", true);
                    }
                }
        }

        //Get the Current Page Relative Path
        public string AppPath()
        {
            string path = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + HttpContext.Current.Request.ApplicationPath;
            return path.EndsWith("/") ? path : path + "/";
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
                createUser.AccountType = "U";
                createUser.RoleId = 0;
                createUser.IsActive = "Y";

                bool IsExist = DataProviderWrapper.Instance.IsEmailExist(createUser.Email);

                if (!IsExist)
                {
                    bool IsSaved = DataProviderWrapper.Instance.AddUpdateUser(createUser);
                    if (IsSaved)
                    {
                        Clear();
                        
                        BLFunction.ShowAlertRedirect(this, "User has been successfully register.", this.AppPath() + "Login", ResponseType.SUCCESS);
                        //Thread.Sleep(1000);
                        //Response.Redirect("~/Login", true);
                    }
                    else
                    {
                        BLFunction.ShowAlert(this, "Unable to register.", ResponseType.WARNING);
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
            txtConfirmPassword.Text = string.Empty;
            txtMobileNumber.Text = string.Empty;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Clear();
        }
    }
}