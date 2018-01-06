using System;
using System.Collections.Generic;
using System.IO;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using Vatas_Common;
using Vatas_Wrapper;

namespace Vatas_UI.Reports
{
    public partial class Search_Jobs_Between_Dates : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string path = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + HttpContext.Current.Request.ApplicationPath;
            txtDateRange.Attributes.Add("readonly", "readonly");
            if (!Page.IsPostBack)
            {
                BindData(DateTime.Now, DateTime.Now);
            }
        }

        public void BindData(DateTime startDate, DateTime endDate)
        {
            List<ReturnsCL> result = DataProviderWrapper.Instance.Report_SearchJobsBetweenDates(startDate, endDate);
            if (result.Count > 0)
            {
                rptReport.DataSource = result;
                rptReport.DataBind();
            }
        }

        public void Export(DateTime startDate, DateTime endDate)
        {
            StringWriter strwriter = new StringWriter();
            string fileName = DateTime.Now.Date.ToString("MM/dd/yyyy") + "_SearchJobsBetweenDates.csv";

            var ResultList = DataProviderWrapper.Instance.Report_SearchJobsBetweenDates(startDate, endDate);
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
            GetDateRange(ref startDate, ref endDate);
            Export(startDate, endDate);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            DateTime startDate = DateTime.Now;
            DateTime endDate = DateTime.Now;
            GetDateRange(ref startDate, ref endDate);
            BindData(startDate, endDate);
        }

        private void GetDateRange(ref DateTime startDate, ref DateTime endDate)
        {
            try
            {
                string dateRange = txtDateRange.Text.Trim();
                if (!string.IsNullOrEmpty(dateRange))
                {
                    string[] date = Regex.Split(dateRange, " - ");
                    startDate = Convert.ToDateTime(date[0].Trim());
                    endDate = Convert.ToDateTime(date[1].Trim());
                }

            }
            catch (Exception ex)
            {
                Console.Write(ex.Message);
                throw;
            }
        }
    }
}