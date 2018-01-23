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
    public partial class ManageMenu1 : System.Web.UI.Page
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
            List<MenuCL> roles = DataProviderWrapper.Instance.GetAllMenu().ToList().Select(p => new MenuCL
            {
                MenuID = Convert.ToInt32(p.DataValue),
                MenuName = p.DataText
            }).ToList();

            if (roles.Count > 0)
            {
                rptMenu.DataSource = roles;
                rptMenu.DataBind();
            }
        }

        protected void btnAddUpdateMenu_Click(object sender, EventArgs e)
        {
            int MenuId = Convert.ToInt32(hdnMenuId.Value);
            string MenuName = txtMenuName.Text;

            bool IsExist = DataProviderWrapper.Instance.IsMenuExist(MenuName);

            if (!IsExist)
            {
                bool IsAddUpdate = DataProviderWrapper.Instance.AddUpdateMenu(MenuId, MenuName);
                if (IsAddUpdate)
                {
                    BLFunction.ShowAlert(this, "Menu has been saved successfully.", ResponseType.SUCCESS);
                    BindData();
                }
                else
                {
                    BLFunction.ShowAlert(this, "Unable to save the Menu.", ResponseType.WARNING);
                }
            }
            else
            {
                BLFunction.ShowAlert(this, "Entered menu is already exist.", ResponseType.SUCCESS);
            }
        }

        protected void btnDeleteMenu_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btnDeleteMenu = (LinkButton)(sender);
                int MenuId = Convert.ToInt32(btnDeleteMenu.CommandArgument);

                bool IsDelete = DataProviderWrapper.Instance.DeleteMenuByMenuId(MenuId);
                if (IsDelete)
                {
                    BLFunction.ShowAlert(this, "Menu has been deleted successfully.", ResponseType.SUCCESS);
                    BindData();
                }
                else
                {
                    BLFunction.ShowAlert(this, "Unable to delete the Menu.", ResponseType.WARNING);
                }
            }
            catch (Exception ex)
            {
                BLFunction.ShowAlert(this, ex.Message, ResponseType.WARNING);
                //throw;
            }
        }
    }
}