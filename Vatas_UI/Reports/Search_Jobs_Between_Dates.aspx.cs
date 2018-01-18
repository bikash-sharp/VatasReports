using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Vatas_Common;
using Vatas_Wrapper;

namespace Vatas_UI.Reports
{
    public partial class Search_Jobs_Between_Dates : VatasWebPage
    {
        int PageNumber = 1;
        int PageSize = 10;

        protected void Page_Load(object sender, EventArgs e)
        {
            txtDateRange.Attributes.Add("readonly", "readonly");
            if (!Page.IsPostBack)
            {
                BindFirmName();
            }
            
        }

        public void BindFirmName()
        {
            List<DropDownCL> firmNames = DataProviderWrapper.Instance.Report_GetAllFirmName();
            ddlFirmName.DataSource = null;
            if (firmNames.Count > 0)
            {
                ddlFirmName.DataSource = firmNames;
                ddlFirmName.DataTextField = "DataText";
                ddlFirmName.DataValueField = "DataValue";
            }
            ddlFirmName.DataBind();
        }


        public void BindData(DateTime startDate, DateTime endDate, int? firmId = null)
        {
            List<ReturnsCL> result = DataProviderWrapper.Instance.Report_SearchJobsBetweenDates(startDate, endDate, firmId, PageNumber, PageSize);
            rptReport.DataSource = null;
            if (result.Count > 0)
            {
                rptReport.DataSource = result;
            }
            rptReport.DataBind();
        }

        public void Export(DateTime startDate, DateTime endDate, int? FirmId)
        {
            StringWriter strwriter = new StringWriter();
            string fileName = DateTime.Now.Date.ToString("MM/dd/yyyy") + "_SearchJobsBetweenDates.csv";

            var ResultList = DataProviderWrapper.Instance.Report_SearchJobsBetweenDates(startDate, endDate, FirmId, PageNumber, PageSize);
            if (ResultList.Count > 0)
            {
                strwriter.WriteLine("\"Sr.No\",\"Firm Name\",\"File No\",\"TAN\",\"Account Name\",\"FY\",\"FormType\",\"Quarter\",\"RetType\",\"Date\"");
                int i = 0;
                foreach (ReturnsCL line in ResultList)
                {
                    i += 1;
                    strwriter.WriteLine(string.Format("\"{0}\",\"{1}\",\"{2}\",\"{3}\",\"{4}\",\"{5}\",\"{6}\",\"{7}\",\"{8}\",\"{9}\"", i, line.FirmName, line.JobNo, line.TAN, line.AccountName, line.FinancialYear, line.FormType, line.Quarter, line.ReturnType, line.Date));
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
            DateTime startDate = DateTime.Now;
            DateTime endDate = DateTime.Now;
            int? FirmId = null;
            if(ddlFirmName.SelectedValue != "0")
            {
                int _firmId = 0;
                int.TryParse(ddlFirmName.SelectedValue, out _firmId);
                FirmId = _firmId;
            }
            GetDateRange(ref startDate, ref endDate);
            Export(startDate, endDate, FirmId);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            int? FirmId = null;
            DateTime startDate = DateTime.Now;
            DateTime endDate = DateTime.Now;
            if (ddlFirmName.SelectedValue != "0")
            {
                FirmId = int.Parse(ddlFirmName.SelectedValue);
            }
            GetDateRange(ref startDate, ref endDate);
            BindData(startDate, endDate, FirmId);
        }

        private void GetDateRange(ref DateTime startDate, ref DateTime endDate)
        {
            try
            {
                string dateRange = txtDateRange.Text.Trim();
                if (!string.IsNullOrEmpty(dateRange))
                {
                    string[] date = Regex.Split(dateRange, " - ");
                    startDate = DateTime.ParseExact(date[0].Trim().Replace('/', '-'), "dd-MM-yyyy", CultureInfo.InvariantCulture);
                    endDate = DateTime.ParseExact(date[1].Trim().Replace('/', '-'), "dd-MM-yyyy", CultureInfo.InvariantCulture);
                }

            }
            catch (Exception ex)
            {
                BLFunction.ShowAlert(this, ex.Message, ResponseType.DANGER);
                //Console.Write(ex.Message);
                //throw;
            }
        }

        protected void ddlFirmName_SelectedIndexChanged(object sender, EventArgs e)
        {
            DateTime startDate = DateTime.Now;
            DateTime endDate = DateTime.Now;
            Nullable<int> FirmId = null;
            GetDateRange(ref startDate, ref endDate);
            if (ddlFirmName.SelectedValue != "0")
            {
                FirmId = int.Parse(ddlFirmName.SelectedValue);
            }
            BindData(startDate, endDate, FirmId);
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

        }
    }
}