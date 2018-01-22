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
    public partial class ManageMenu : System.Web.UI.Page
    {
        HttpContext CurrContext = HttpContext.Current;
        static int RoleId = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    RoleId = Convert.ToInt32(CurrContext.Items["RoleId"].ToString());
                    BindMenu(RoleId);
                    BindData(RoleId);
                }
                catch (Exception ex)
                {
                    Server.Transfer("ManageRoles.aspx");
                }
            }
        }

        public string AppPath()
        {
            string path = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + HttpContext.Current.Request.ApplicationPath;
            return path.EndsWith("/") ? path : path + "/";
        }

        public void BindMenu(int RoleId)
        {
            List<DropDownCL> roles = DataProviderWrapper.Instance.GetAllMenu();
            ddlMenu.DataSource = null;
            if (roles.Count > 0)
            {
                ddlMenu.DataSource = roles;
                ddlMenu.DataTextField = "DataText";
                ddlMenu.DataValueField = "DataValue";
            }
            ddlMenu.DataBind();
        }
        public void BindData(int RoleId)
        {
            var menu = DataProviderWrapper.Instance.GetMenuByRoleId(RoleId);
            if (menu.Count > 0)
            {
                rptMenu.DataSource = menu;
                rptMenu.DataBind();
            }
        }

        protected void btnDeleteMenu_Click(object sender, EventArgs e)
        {
            try
            {
                Button btnDeleteUser = (Button)(sender);
                int MenuId = Convert.ToInt32(btnDeleteUser.CommandArgument);

                bool IsDelete = DataProviderWrapper.Instance.DeleteUserMenuByMenuId(RoleId, MenuId);
                if (IsDelete)
                {
                    BLFunction.ShowAlert(this, "Menu has been deleted successfully.", ResponseType.SUCCESS);
                    BindData(RoleId);
                }
                else
                {
                    BLFunction.ShowAlert(this, "Unable to delete the menu.", ResponseType.WARNING);
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        protected void btnAddUpdateMenu_Click(object sender, EventArgs e)
        {
            int MenuId = Convert.ToInt32(ddlMenu.SelectedValue);

            bool IsExist = DataProviderWrapper.Instance.IsMenuAlreadyExistInUserMenu(RoleId,MenuId);

            if (!IsExist)
            {
                bool IsAddUpdate = DataProviderWrapper.Instance.AddMenuToUserMenuByRoleId(RoleId, MenuId);
                if (IsAddUpdate)
                {
                    BLFunction.ShowAlert(this, "Menu has been saved successfully.", ResponseType.SUCCESS);
                    BindData(RoleId);
                }
                else
                {
                    BLFunction.ShowAlert(this, "Unable to save the Menu.", ResponseType.WARNING);
                }
            }
            else
            {
                BLFunction.ShowAlert(this, "Entered Menu is already exist.", ResponseType.SUCCESS);
            }
        }
    }
}