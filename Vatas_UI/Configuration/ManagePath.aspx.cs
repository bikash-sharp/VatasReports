using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Vatas_Common;
using Vatas_Wrapper;

namespace Vatas_UI.Configuration
{
    public partial class ManagePath : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (BLFunction.GetRoleName().ToLower() == "superadmin")
                {
                    BindData();
                }
                else
                {
                    Response.RedirectToRoute("401");
                }
            }
        }

        public string AppPath()
        {
            string path = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + HttpContext.Current.Request.ApplicationPath;
            return path.EndsWith("/") ? path : path + "/";
        }

        public void BindProject()
        {
            List<DropDownCL> project = DataProviderWrapper.Instance.GetAllProject();
            ddlProject.DataSource = null;
            if (project.Count > 0)
            {
                ddlProject.DataSource = project;
                ddlProject.DataTextField = "DataText";
                ddlProject.DataValueField = "DataValue";
            }
            ddlProject.DataBind();
        }

        public void BindData()
        {
            var result = DataProviderWrapper.Instance.GetAllPath();
            if (result.Count > 0)
            {
                rptPath.DataSource = result;
                rptPath.DataBind();
            }
            BindProject();
        }

        protected void btnAddUpdatePath_Click(object sender, EventArgs e)
        {
            PathCL _path = new PathCL();
            int pathId = Convert.ToInt32(hdnPathId.Value);
            string pathName = txtPathName.Text.Trim();
            string host = txtHost.Text.Trim();
            string path = txtPath.Text.Trim();
            string pathProject = ddlProject.SelectedValue;

            _path.PathID = pathId;
            _path.PathName = pathName;
            _path.Host = host;
            _path.Path = path;
            _path.PathProject = pathProject;

            //bool IsExist = DataProviderWrapper.Instance.IsPathAlreadyExist(_path);
            bool IsExist = false;

            if (!IsExist)
            {
                bool IsAddUpdate = DataProviderWrapper.Instance.AddUpdatePath(_path);
                if (IsAddUpdate)
                {
                    BLFunction.ShowAlert(this, "Path has been saved successfully.", ResponseType.SUCCESS);
                    BindData();
                }
                else
                {
                    BLFunction.ShowAlert(this, "Unable to save the Path.", ResponseType.WARNING);
                }
            }
            else
            {
                BLFunction.ShowAlert(this, "Entered Path is already exist.", ResponseType.SUCCESS);
            }
        }
    }
}