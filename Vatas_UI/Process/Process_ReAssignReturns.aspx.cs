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
    public partial class Process_ReAssignReturns : VatasWebPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindData();
        }

        public void BindData()
        {
            List<ProcessReturnsCL> result = DataProviderWrapper.Instance.GetReturnsByJobStatus("ASS");
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
                var frontOfcList = DataProviderWrapper.Instance.GetReturnsByJobStatus("ASS");
                foreach (RepeaterItem item in rptProcess.Items)
                {
                    ProcessReturnsCL itemProcess = new ProcessReturnsCL();
                    HiddenField hfId = (HiddenField)item.FindControl("hfId");
                    CheckBox chkRow = (CheckBox)item.FindControl("chkRow");
                    DropDownList ddlOperator = (DropDownList)item.FindControl("ddlOperator");
                    if (chkRow != null && hfId != null && ddlOperator != null)
                    {
                        if (chkRow.Checked == true)
                        {
                            int jobID = int.Parse(hfId.Value);

                            itemProcess = frontOfcList.FirstOrDefault(p => p.JobID == jobID);
                            itemProcess.CurrentJobStatus = "ASS";
                            itemProcess.NextUserID = int.Parse(ddlOperator.SelectedItem.Value);
                            processList.Add(itemProcess);
                        }
                    }
                }

                var result = DataProviderWrapper.Instance.ProcessReturns(processList, BLFunction.GetUserID());
                if (result.Response == ResponseType.SUCCESS)
                {
                    BLFunction.ShowAlert(this, "Returns has been Assigned.", result.Response);
                }
                else
                {
                    BLFunction.ShowAlert(this, "Error !!! Returns can not Assigned.", result.Response);
                }
            }
            else
            {
                BLFunction.ShowAlert(this, "Invalid page request found. Reload again and try once again.", ResponseType.INFO);
            }

            BindData();
        }

        protected void rptProcess_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var ddlOperator = e.Item.FindControl("ddlOperator") as DropDownList;
                var hfSelectedUserID = e.Item.FindControl("hfSelectedUserID") as HiddenField;
                if( !String.IsNullOrEmpty(hfSelectedUserID.Value) && hfSelectedUserID.Value != "0")
                {
                    ddlOperator.Items.OfType<ListItem>().Where(p => p.Value == hfSelectedUserID.Value).ToList().ForEach(p=>p.Selected = true);
                }
            }
        }
    }
}