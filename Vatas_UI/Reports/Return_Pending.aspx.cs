using System;
using System.Collections.Generic;
using System.IO;
using System.Web.UI;
using Vatas_Common;
using Vatas_Wrapper;

namespace Vatas_UI.Reports
{
    public partial class Return_Pending : VatasWebPage
    {
        string JobStatus = "RDV";
        char IsSent;
        int PageNumber = 1;
        int PageSize = 10;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindData();
            }
        }

        public void BindData()
        {
            List<ReturnsCL> result = DataProviderWrapper.Instance.Report_GetReturnsByJobStatus(JobStatus, IsSent, PageNumber, PageSize);
            if (result.Count > 0)
            {
                rptReport.DataSource = result;
                rptReport.DataBind();
            }
        }

        public void Export()
        {
            StringWriter strwriter = new StringWriter();
            string fileName = DateTime.Now.Date.ToString("MM/dd/yyyy") + "_ReturnsPending.csv";

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
    }
}