using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
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

        static Int32 RecordCount = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                btnSearch_Click(btnSearch, null);
            }
        }

        public void BindData(string JobStatus, char IsSent, int PageNumber, int PageSize, string SearchText)
        {
            int TotalPages = 0;
            List<ReturnsCL> result = DataProviderWrapper.Instance.Report_GetReturnsByJobStatus(JobStatus, IsSent, PageNumber, PageSize, SearchText);
            rptReport.DataSource = null;
            if (result.Count > 0)
            {
                rptReport.DataSource = result;
                int.TryParse(result.FirstOrDefault()?.RecordCount + "", out TotalPages);
            }
            rptReport.DataBind();
            RecordCount = TotalPages;
            float pages = Convert.ToSingle(TotalPages) / Convert.ToSingle(PageSize);
            TotalPages = Convert.ToInt32(Math.Ceiling(pages));
            hidPages.Value = TotalPages.ToString();
        }

        public void Export()
        {
            int PageNumber = 1;
            int.TryParse(hidPageNo.Value, out PageNumber);

            int PageSize = 10;
            int.TryParse(ddlPageLength.SelectedValue, out PageSize);
            if (PageSize <= 0)
            {
                PageSize = RecordCount;
            }
            string SearchText = txtSearch.Text.Trim();


            StringWriter strwriter = new StringWriter();
            string fileName = DateTime.Now.Date.ToString("MM/dd/yyyy") + "_ReturnsAssigned.csv";

            var ResultList = DataProviderWrapper.Instance.Report_GetReturnsByJobStatus(JobStatus, IsSent, PageNumber, PageSize, SearchText);
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

        protected void ddlPageLength_SelectedIndexChanged(object sender, EventArgs e)
        {
            hidPageNo.Value = "1";
            btnSearch_Click(btnSearch, null);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            int CurrentPageNo = 1;
            int.TryParse(hidPageNo.Value, out CurrentPageNo);

            int PageSize = 10;
            int.TryParse(ddlPageLength.SelectedValue, out PageSize);
            if (PageSize <= 0)
            {
                PageSize = RecordCount;
            }
            string SearchText = txtSearch.Text.Trim();

            BindData(JobStatus, IsSent, CurrentPageNo, PageSize, SearchText);
        }

        protected void lnkExportToPdf_Click(object sender, EventArgs e)
        {
            ExportToPdf();
        }

        public void ExportToPdf()
        {
            int PageNumber = 1;
            int.TryParse(hidPageNo.Value, out PageNumber);

            int PageSize = 10;
            int.TryParse(ddlPageLength.SelectedValue, out PageSize);
            if (PageSize <= 0)
            {
                PageSize = RecordCount;
            }
            string SearchText = txtSearch.Text.Trim();

            string fileName = DateTime.Now.Date.ToString("MM/dd/yyyy") + "_ReturnsAssigned.pdf";
            string filePath = Path.Combine(Server.MapPath("~/PDFFiles"), fileName);
            var normalFont = FontFactory.GetFont(FontFactory.HELVETICA, 12);
            var boldFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 12);

            Document doc = new Document(iTextSharp.text.PageSize.A4.Rotate(), 1, 1, 1, 1);
            Paragraph p = new Paragraph("Report - Assigned Return", boldFont);
            p.Alignment = Element.ALIGN_CENTER;
            p.PaddingTop = 10f;
            p.SpacingAfter = 20f;
            p.SpacingBefore = 20f;

            try
            {
                PdfWriter.GetInstance(doc, new FileStream(filePath, FileMode.Create));
                PdfPTable pdfTab = new PdfPTable(12);
                pdfTab.HorizontalAlignment = Element.ALIGN_CENTER;
                pdfTab.WidthPercentage = 90;
                pdfTab.SpacingBefore = 0f;
                pdfTab.SpacingAfter = 0f;

                var ResultList = DataProviderWrapper.Instance.Report_GetReturnsByJobStatus(JobStatus, IsSent, PageNumber, PageSize, SearchText);

                if (ResultList.Count > 0)
                {
                    pdfTab.AddCell(new PdfPCell(new Paragraph("Sr.No", boldFont)));
                    pdfTab.AddCell(new PdfPCell(new Paragraph("Firm Name", boldFont)));
                    pdfTab.AddCell(new PdfPCell(new Paragraph("File No", boldFont)));
                    pdfTab.AddCell(new PdfPCell(new Paragraph("TAN", boldFont)));
                    pdfTab.AddCell(new PdfPCell(new Paragraph("AccountName", boldFont)));
                    pdfTab.AddCell(new PdfPCell(new Paragraph("FinancialYear", boldFont)));
                    pdfTab.AddCell(new PdfPCell(new Paragraph("FormType", boldFont)));
                    pdfTab.AddCell(new PdfPCell(new Paragraph("Quarter", boldFont)));
                    pdfTab.AddCell(new PdfPCell(new Paragraph("ReturnType", boldFont)));
                    pdfTab.AddCell(new PdfPCell(new Paragraph("Date", boldFont)));
                    pdfTab.AddCell(new PdfPCell(new Paragraph("AssignedDate", boldFont)));
                    pdfTab.AddCell(new PdfPCell(new Paragraph("OperatorName", boldFont)));

                    int i = 0;
                    foreach (ReturnsCL line in ResultList)
                    {
                        i += 1;

                        pdfTab.AddCell(i.ToString());
                        pdfTab.AddCell(line.FirmName.ToString());
                        pdfTab.AddCell(line.JobNo.ToString());
                        pdfTab.AddCell(line.TAN.ToString());
                        pdfTab.AddCell(line.AccountName.ToString());
                        pdfTab.AddCell(line.FinancialYear.ToString());
                        pdfTab.AddCell(line.FormType.ToString());
                        pdfTab.AddCell(line.Quarter.ToString());
                        pdfTab.AddCell(line.ReturnType.ToString());
                        pdfTab.AddCell(line.Date);
                        pdfTab.AddCell(line.AssignedDate);
                        pdfTab.AddCell(line.Username);
                    }

                }

                doc.Open();
                doc.Add(p);
                doc.Add(pdfTab);
                doc.Close();
                byte[] content = File.ReadAllBytes(filePath);
                HttpContext context = HttpContext.Current;
                context.Response.BinaryWrite(content);
                context.Response.ContentType = "application/pdf";
                context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);
                context.Response.End();
            }
            catch (Exception ex)
            {
                throw;
            }
            finally
            {
                doc.Close();
            }
        }
    }
}