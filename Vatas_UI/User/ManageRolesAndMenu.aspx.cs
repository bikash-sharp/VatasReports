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
    public partial class ManageRolesAndMenu : System.Web.UI.Page
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
            List<RoleCL> roles = DataProviderWrapper.Instance.GetAllRoles().ToList().Select(p => new RoleCL
            {
                RoleId = Convert.ToInt32(p.DataValue),
                RoleName = p.DataText
            }).ToList();

            if (roles.Count > 0)
            {
                rptRole.DataSource = roles;
                rptRole.DataBind();
            }
        }

        protected void btnDeleteRole_Click(object sender, EventArgs e)
        {
            try
            {
                Button btnDeleteUser = (Button)(sender);
                int UserId = Convert.ToInt32(btnDeleteUser.CommandArgument);

                bool IsDelete = DataProviderWrapper.Instance.DeleteRegisteredUser(UserId);
                if (IsDelete)
                {
                    BLFunction.ShowAlert(this, "Role has been deleted Successfully.", ResponseType.SUCCESS);
                    BindData();
                }
                else
                {
                    BLFunction.ShowAlert(this, "Unable to delete the role.", ResponseType.WARNING);
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        protected void btnViewMenu_Click(object sender, EventArgs e)
        {
            Button btnEditRole = (Button)(sender);
            int RoleId = Convert.ToInt32(btnEditRole.CommandArgument);

            HttpContext _context = HttpContext.Current;
            _context.Items.Add("RoleId", RoleId);

            Server.Transfer("~/User/MenuByRole.aspx");
            //Response.Redirect("EditUser.aspx?UserId=1");
        }

        protected void btnEditRole_Click(object sender, EventArgs e)
        {
            Button btnEditRole = (Button)(sender);
            int RoleId = Convert.ToInt32(btnEditRole.CommandArgument);

            HttpContext _context = HttpContext.Current;
            _context.Items.Add("RoleId", RoleId);

            Server.Transfer("~/User/AddUpdateRole.aspx");
            //Response.Redirect("EditUser.aspx?UserId=1");
        }
    }
}