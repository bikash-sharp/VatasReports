﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Vatas_Common;
using Vatas_Wrapper;

namespace Vatas_UI.Process
{
    public partial class Process_BackOfficeReturns : VatasWebPage
    {
        int PageNumber = 1;
        int PageSize = 10;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnSearch_Click(btnSearch, null);
            }
        }
        public void BindData(int PageNumber, int PageSize, string SearchText)
        {
            int TotalPages = 0;
            List<ProcessReturnsCL> result = DataProviderWrapper.Instance.GetReturnsByJobStatus("BO", PageNumber, PageSize, SearchText);
            rptProcess.DataSource = null;
            if (result.Count > 0)
            {
                rptProcess.DataSource = result;
                int.TryParse(result.FirstOrDefault()?.RecordCount + "", out TotalPages);
            }
            rptProcess.DataBind();
            float pages = Convert.ToSingle(TotalPages) / Convert.ToSingle(PageSize);
            TotalPages = Convert.ToInt32(Math.Ceiling(pages));
            hidPages.Value = TotalPages.ToString();
        }
        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            int PageNumber = 1;
            int.TryParse(hidPageNo.Value, out PageNumber);

            int PageSize = 10;
            int.TryParse(ddlPageLength.SelectedValue, out PageSize);

            string SearchText = txtSearch.Text.Trim();

            if (this.IsValid)
            {
                List<ProcessReturnsCL> processList = new List<ProcessReturnsCL>();
                var frontOfcList = DataProviderWrapper.Instance.GetReturnsByJobStatus("BO", PageNumber, PageSize);
                foreach (RepeaterItem item in rptProcess.Items)
                {
                    ProcessReturnsCL itemProcess = new ProcessReturnsCL();
                    HiddenField hfId = (HiddenField)item.FindControl("hfId");
                    CheckBox chkRow = (CheckBox)item.FindControl("chkRow");
                    TextBox txtReasons = (TextBox)item.FindControl("txtReasons");

                    DropDownList ddlProcessType = (DropDownList)item.FindControl("ddlProcessType");
                    if (chkRow != null && hfId != null && ddlProcessType != null && txtReasons != null)
                    {
                        if (chkRow.Checked == true)
                        {
                            int jobID = int.Parse(hfId.Value);

                            itemProcess = frontOfcList.FirstOrDefault(p => p.JobID == jobID);
                            itemProcess.CurrentJobStatus = ddlProcessType.SelectedItem.Value;
                            itemProcess.ReasonforReturn = txtReasons.Text.Trim();
                            processList.Add(itemProcess);
                        }
                    }
                }

                var result = DataProviderWrapper.Instance.ProcessReturns(processList, BLFunction.GetUserID());
                if (result.Response == ResponseType.SUCCESS)
                {
                    BLFunction.ShowAlert(this, "Returns has been sent.", result.Response);
                }
                else
                {
                    BLFunction.ShowAlert(this, "Error !!! Returns can not sent.", result.Response);
                }
            }
            else
            {
                BLFunction.ShowAlert(this, "Invalid page request found. Reload again and try once again.", ResponseType.INFO);
            }

            BindData(PageNumber, PageSize, SearchText);
        }
        public void Export()
        {
            int PageNumber = 1;
            int.TryParse(hidPageNo.Value, out PageNumber);

            int PageSize = 10;
            int.TryParse(ddlPageLength.SelectedValue, out PageSize);

            string SearchText = txtSearch.Text.Trim();

            StringWriter strwriter = new StringWriter();
            string fileName = DateTime.Now.Date.ToString("MM/dd/yyyy") + "_Process_FrontOfficeReturns.csv";

            List<ProcessReturnsCL> processList = new List<ProcessReturnsCL>();
            var frontOfcList = DataProviderWrapper.Instance.GetReturnsByJobStatus("FO", PageNumber, PageSize, SearchText);

            if (frontOfcList.Count > 0)
            {
                strwriter.WriteLine("\"Sr.No\",\"SendTo\",\"ReasonToReturn\",\"JobNo\",\"TAN\",\"AccountName\",\"FinancialYear\",\"FormType\",\"Quarter\",\"ReturnType\"");
                int i = 0;
                foreach (RepeaterItem item in rptProcess.Items)
                {
                    ProcessReturnsCL itemProcess = new ProcessReturnsCL();
                    HiddenField hfId = (HiddenField)item.FindControl("hfId");
                    Label lblSrno = (Label)item.FindControl("lblSrno");
                    TextBox txtReasons = (TextBox)item.FindControl("txtReasons");
                    Label lblTAN = (Label)item.FindControl("lblTAN");
                    Label lblJobNo = (Label)item.FindControl("lblJobNo");
                    Label lblAccountName = (Label)item.FindControl("lblAccountName");
                    Label lblFinancialYear = (Label)item.FindControl("lblFinancialYear");
                    Label lblFormNumber = (Label)item.FindControl("lblFormNumber");
                    Label lblQuarter = (Label)item.FindControl("lblQuarter");
                    Label lblReturnType = (Label)item.FindControl("lblReturnType");
                    CheckBox chkRow = (CheckBox)item.FindControl("chkRow");
                    DropDownList ddlProcessType = (DropDownList)item.FindControl("ddlProcessType");

                    if (chkRow != null && hfId != null && ddlProcessType != null)
                    {
                        //if (chkRow.Checked == true)
                        {
                            int JobID = string.IsNullOrEmpty(hfId.Value) ? 0 : int.Parse(hfId.Value);
                            int JobNo = int.Parse(lblJobNo.Text);
                            string Reasons = txtReasons.Text;
                            string ProcessType = "";
                            if (!string.IsNullOrEmpty(ddlProcessType.SelectedItem.ToString()))
                            {
                                ProcessType = ddlProcessType.SelectedItem.Text;
                            }
                            string Srno = lblSrno.Text;
                            string AccountName = lblAccountName.Text;
                            string TAN = lblTAN.Text;
                            string FinancialYear = lblFinancialYear.Text;
                            string FormNumber = lblFormNumber.Text;
                            string Quarter = lblQuarter.Text;
                            string ReturnType = lblReturnType.Text;

                            strwriter.WriteLine(string.Format("\"{0}\",\"{1}\",\"{2}\",\"{3}\",\"{4}\",\"{5}\",\"{6}\",\"{7}\",\"{8}\",\"{9}\"",
                                Srno, ProcessType, Reasons, JobNo, AccountName, TAN, FinancialYear, FormNumber, Quarter, ReturnType));

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
        protected void ddlPageLength_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnSearch_Click(btnSearch, null);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            int CurrentPageNo = 1;
            int.TryParse(hidPageNo.Value, out CurrentPageNo);

            int PageSize = 10;
            int.TryParse(ddlPageLength.SelectedValue, out PageSize);

            string SearchText = txtSearch.Text.Trim();

            BindData(CurrentPageNo, PageSize, SearchText);
        }

    }
}