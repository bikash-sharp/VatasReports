using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Vatas_Common;
using Vatas_Wrapper;

namespace Vatas_UI.Reports
{
    public partial class Return_Assigned : VatasWebPage
    {
        string JobStatus = "ASS";
        char IsSent;
        int PageNumber = 1;
        int PageSize = 10;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindData(PageNumber);
            }
        }

        public void BindData(int PageNumber)
        {
            List<ReturnsCL> result = DataProviderWrapper.Instance.Report_GetReturnsByJobStatus(JobStatus, IsSent, PageNumber, PageSize);
            if (result.Count > 0)
            {
                rptReport.DataSource = result;
                rptReport.DataBind();

                this.PopulatePager(result[0].RecordCount, PageNumber);

                hdnPages.Value = (Math.Ceiling((double)result[0].RecordCount / PageSize)).ToString();
                hdnPageSize.Value = PageSize.ToString();
                hdnPageNumber.Value = PageNumber.ToString();
                hdnRecordCount.Value = result[0].RecordCount.ToString();
            }
        }

        public void Export()
        {
            StringWriter strwriter = new StringWriter();
            string fileName = DateTime.Now.Date.ToString("MM/dd/yyyy") + "_ReturnsAssigned.csv";

            var ResultList = DataProviderWrapper.Instance.Report_GetReturnsByJobStatus(JobStatus, IsSent, PageNumber, PageSize);
            if (ResultList.Count > 0)
            {
                strwriter.WriteLine("\"Sr.No\",\"Firm Name\",\"File No\",\"TAN\",\"Account Name\",\"FY\",\"FormType\",\"Quarter\",\"RetType\",\"Date\",\"AssignedDate\",\"OperatorName\"");
                int i = 0;
                foreach (ReturnsCL line in ResultList)
                {
                    i += 1;
                    strwriter.WriteLine(string.Format("\"{0}\",\"{1}\",\"{2}\",\"{3}\",\"{4}\",\"{5}\",\"{6}\",\"{7}\",\"{8}\",\"{9}\",\"{10}\",\"{11}\"", i, line.FirmName, line.JobNo, line.TAN, line.AccountName, line.FinancialYear, line.FormType, line.Quarter, line.ReturnType, line.Date, line.AssignedDate, line.Username));
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

        private void PopulatePager(int recordCount, int currentPage)
        {
            double dblPageCount = (double)((decimal)recordCount / Convert.ToDecimal(PageSize));
            int pageCount = (int)Math.Ceiling(dblPageCount);
            List<ListItem> pages = new List<ListItem>();
            if (pageCount > 0)
            {
                for (int i = 1; i <= pageCount; i++)
                {
                    pages.Add(new ListItem(i.ToString(), i.ToString(), i != currentPage));
                }
            }
            rptPager.DataSource = pages;
            rptPager.DataBind();
        }

        protected void Page_Changed(object sender, EventArgs e)
        {
            PageNumber = int.Parse((sender as LinkButton).CommandArgument);
            this.BindData(PageNumber);
        }
    }
}