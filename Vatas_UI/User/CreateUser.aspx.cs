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
    public partial class CreateUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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

                bool IsSaved = DataProviderWrapper.Instance.AddUpdateUser(createUser);
                if (IsSaved)
                {
                    Clear();
                    BLFunction.ShowAlert(this, "New User Created Successfully", ResponseType.SUCCESS);
                }
                else
                {
                    BLFunction.ShowAlert(this, "Unable To Create a New User.", ResponseType.WARNING);
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

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Clear();
        }
    }
}