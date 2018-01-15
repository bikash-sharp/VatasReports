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
                User createUser = new User();

                createUser.FirstName = txtFirstName.Text;
                createUser.LastName = txtLastName.Text;
                createUser.Email = txtEmail.Text;
                createUser.Password = txtPassword.Text;
                createUser.MobileNumber = txtMobileNumber.Text;
                createUser.AccountType = ddlAccountType.SelectedItem.Text;

                bool IsSaved = DataProviderWrapper.Instance.SaveNewUser(createUser);
                if (IsSaved)
                    Clear();
            }
            catch (Exception ex)
            {

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
    }
}