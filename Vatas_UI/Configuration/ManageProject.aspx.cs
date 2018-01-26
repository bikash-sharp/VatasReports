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
    public partial class ManageProject : System.Web.UI.Page
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
            var project = DataProviderWrapper.Instance.GetAllProject().ToList().Select(p => new ProjectCL
            {
                ProjectId = Convert.ToInt32(p.DataValue),
                ProjectName = p.DataText
            }).ToList();

            if (project.Count > 0)
            {
                rptProject.DataSource = project;
                rptProject.DataBind();
            }
        }

        protected void btnAddUpdateProject_Click(object sender, EventArgs e)
        {
            int ProjectId = Convert.ToInt32(hdnProjectId.Value);
            string ProjectName = txtProjectName.Text;

            bool IsExist = DataProviderWrapper.Instance.IsProjectAlreadyExist(ProjectName);

            if (!IsExist)
            {
                bool IsAddUpdate = DataProviderWrapper.Instance.AddUpdateProject(ProjectId, ProjectName);
                if (IsAddUpdate)
                {
                    BLFunction.ShowAlert(this, "project has been saved successfully.", ResponseType.SUCCESS);
                    BindData();
                }
                else
                {
                    BLFunction.ShowAlert(this, "Unable to save the project.", ResponseType.WARNING);
                }
            }
            else
            {
                BLFunction.ShowAlert(this, "Entered project is already exist.", ResponseType.SUCCESS);
            }

        }
    }
}