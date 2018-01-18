using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
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
        int PageNumber = 1;
        int PageSize = 10;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            BindData();
        }

        public void BindData()
        {
            List<ProcessReturnsCL> result = DataProviderWrapper.Instance.GetReturnsByJobStatus("FO", PageNumber, PageSize);
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
                var frontOfcList = DataProviderWrapper.Instance.GetReturnsByJobStatus("FO", PageNumber, PageSize);
                foreach (RepeaterItem item in rptProcess.Items)
                {
                    ProcessReturnsCL itemProcess = new ProcessReturnsCL();
                    HiddenField hfId = (HiddenField)item.FindControl("hfId");
                    CheckBox chkRow = (CheckBox)item.FindControl("chkRow");
                    DropDownList ddlSupervisor = (DropDownList)item.FindControl("ddlSupervisor");
                    DropDownList ddlPriority = (DropDownList)item.FindControl("ddlPriorities");
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

                var result = DataProviderWrapper.Instance.ProcessReturns(processList, BLFunction.GetUserID());
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

        public void Export()
        {
            StringWriter strwriter = new StringWriter();
            string fileName = DateTime.Now.Date.ToString("MM/dd/yyyy") + "_Process_FrontOfficeReturns.csv";

            List<ProcessReturnsCL> processList = new List<ProcessReturnsCL>();
            var frontOfcList = DataProviderWrapper.Instance.GetReturnsByJobStatus("FO", PageNumber, PageSize);

            if (frontOfcList.Count > 0)
            {
                strwriter.WriteLine("\"Sr.No\",\"NameOfSupervisor\",\"Priority\",\"JobNo\",\"TAN\",\"AccountName\",\"FinancialYear\",\"FormType\",\"Quarter\",\"ReturnType\"");
                int i = 0;
                foreach (RepeaterItem item in rptProcess.Items)
                {
                    ProcessReturnsCL itemProcess = new ProcessReturnsCL();
                    HiddenField hfId = (HiddenField)item.FindControl("hfId");
                    Label lblSrno = (Label)item.FindControl("lblSrno");
                    Label lblTAN = (Label)item.FindControl("lblTAN");
                    Label lblJobNo = (Label)item.FindControl("lblJobNo");
                    Label lblAccountName = (Label)item.FindControl("lblAccountName");
                    Label lblFinancialYear = (Label)item.FindControl("lblFinancialYear");
                    Label lblFormNumber = (Label)item.FindControl("lblFormNumber");
                    Label lblQuarter = (Label)item.FindControl("lblQuarter");
                    Label lblReturnType = (Label)item.FindControl("lblReturnType");
                    CheckBox chkRow = (CheckBox)item.FindControl("chkRow");
                    DropDownList ddlSupervisor = (DropDownList)item.FindControl("ddlSupervisor");
                    DropDownList ddlPriority = (DropDownList)item.FindControl("ddlPriorities");

                    if (chkRow != null && hfId != null && ddlSupervisor != null && ddlPriority != null)
                    {
                        //if (chkRow.Checked == true)
                        {
                            int JobID = string.IsNullOrEmpty(hfId.Value) ? 0 : int.Parse(hfId.Value);
                            int JobNo = int.Parse(lblJobNo.Text);
                            int PriorityID = int.Parse(ddlPriority.SelectedValue);
                            string Prioritytype = "";
                            if (!string.IsNullOrEmpty(ddlPriority.SelectedItem.ToString()))
                            {
                                if (int.Parse(ddlPriority.SelectedItem.Value) != 1)
                                    Prioritytype = ddlPriority.SelectedItem.Text;
                            }
                            string SupervisorName = "";
                            if (!string.IsNullOrEmpty(ddlSupervisor.SelectedItem.ToString()))
                            {
                                SupervisorName = ddlSupervisor.SelectedItem.Text;
                            }
                            string Srno = lblSrno.Text;
                            string AccountName = lblAccountName.Text;
                            string TAN = lblTAN.Text;
                            string FinancialYear = lblFinancialYear.Text;
                            string FormNumber = lblFormNumber.Text;
                            string Quarter = lblQuarter.Text;
                            string ReturnType = lblReturnType.Text;

                            strwriter.WriteLine(string.Format("\"{0}\",\"{1}\",\"{2}\",\"{3}\",\"{4}\",\"{5}\",\"{6}\",\"{7}\",\"{8}\",\"{9}\"",
                                Srno, SupervisorName, Prioritytype, JobNo, AccountName, TAN, FinancialYear, FormNumber, Quarter, ReturnType));

                        }
                    }
                }
                Response.Buffer = false;
                Response.ClearContent();
                Response.AddHeader("content-disposition", "attachment;filename=" + fileName);
                Response.ContentType = "text/csv";
                Response.Write(strwriter.ToString());
                Response.End();
            }
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            Export();
        }
    }
}