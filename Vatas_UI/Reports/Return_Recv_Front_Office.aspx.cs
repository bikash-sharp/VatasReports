﻿using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Vatas_Common;
using Vatas_Wrapper;

namespace Vatas_UI.Reports
{
    public partial class Return_Recv_Front_Office : VatasWebPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindData();
            }
        }

        public void BindData()
        {
            List<ReturnsCL> result  = DataProviderWrapper.Instance.ReturnsAtFrontPage();
            if (result.Count > 0)
            {
                rptReport.DataSource = result;
                rptReport.DataBind();
            }
        }

        public void Export()
        {
            StringWriter strwriter = new StringWriter();
            string fileName = DateTime.Now.Date.ToString("MM/d/yyyy") + "_ReturnsAtFrontOffice.csv";

            var ResultList = DataProviderWrapper.Instance.ReturnsAtFrontPage();
            if (ResultList.Count > 0)
            {
                strwriter.WriteLine("\"Sr.No\",\"Firm Name\",\"File No\",\"TAN\",\"Account Name\",\"FY\",\"FormType\",\"Quarter\",\"RetType\",\"Date\"");
                int i = 0;
                foreach (ReturnsCL line in ResultList)
                {
                    i += 1;
                    strwriter.WriteLine(string.Format("\"{0}\",\"{1}\",\"{2}\",\"{3}\",\"{4}\",\"{5}\",\"{6}\",\"{7}\",\"{8}\",\"{9}\"",i, line.FirmName, line.JobNo, line.TAN, line.AccountName, line.FinancialYear, line.FormType, line.Quarter,line.ReturnType, line.Date));
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