using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Vatas_Common;
using Vatas_Wrapper;

namespace Vatas_UI.Process
{
    public partial class Process_FrontOfficeReturns : VatasWebPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BindData();
        }

        public void BindData()
        {
            List<ProcessReturnsCL> result = DataProviderWrapper.Instance.GetReturnsByJobStatus("FO");
            rptProcess.DataSource = null;
            if (result.Count > 0)
            {
                rptProcess.DataSource = result;
            }
            rptProcess.DataBind();
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            if (this.IsValid)
            {
                List<ProcessReturnsCL> processList = new List<ProcessReturnsCL>();
                var frontOfcList = DataProviderWrapper.Instance.GetReturnsByJobStatus("FO");
                foreach (RepeaterItem item in rptProcess.Items)
                {
                    ProcessReturnsCL itemProcess = new ProcessReturnsCL();
                    HiddenField hfId = (HiddenField) item.FindControl("hfId");
                    CheckBox chkRow = (CheckBox) item.FindControl("chkRow");
                    DropDownList ddlSupervisor = (DropDownList) item.FindControl("ddlSupervisor");
                    DropDownList ddlPriority = (DropDownList) item.FindControl("ddlPriorities");
                    if (chkRow != null && hfId != null && ddlSupervisor != null && ddlPriority != null)
                    {
                        if (chkRow.Checked == true)
                        {
                            int jobID = int.Parse(hfId.Value);
                            //int SupervisorID = int.Parse(ddlSupervisor.SelectedValue);
                            int PriorityID = int.Parse(ddlPriority.SelectedValue);


                            itemProcess = frontOfcList.FirstOrDefault(p => p.JobID == jobID);
                            //itemProcess.Prioritytype = ddlPriority.SelectedItem.Text;
                            itemProcess.SupervisorName = ddlSupervisor.SelectedItem.Text;
                            //itemProcess.SupervisorID = SupervisorID;
                            itemProcess.PriorityID = PriorityID;
                            itemProcess.CurrentJobStatus = "BO";
                            processList.Add(itemProcess);
                        }
                    }
                }

                var result = DataProviderWrapper.Instance.ProcessReturns(processList,BLFunction.GetUserID());
                if (result.Response == ResponseType.SUCCESS)
                {
                    BLFunction.ShowAlert(this, "Returns has been sent to Back Office", result.Response);
                }
                else
                {
                    BLFunction.ShowAlert(this, "Error !!! Returns can not sent to Back Office", result.Response);
                }
            }
            else
            {
                BLFunction.ShowAlert(this, "Invalid page request found. Reload again and try once again.", ResponseType.INFO);
            }

            BindData();
        }
    }
}