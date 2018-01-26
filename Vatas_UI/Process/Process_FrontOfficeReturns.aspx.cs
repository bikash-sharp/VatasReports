using iTextSharp.text;
using iTextSharp.text.pdf;
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
        static Int32 RecordCount = 0;
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
            List<ProcessReturnsCL> result = DataProviderWrapper.Instance.GetReturnsByJobStatus("FO", PageNumber, PageSize, SearchText);
            rptProcess.DataSource = null;
            if (result.Count > 0)
            {
                rptProcess.DataSource = result;
                int.TryParse(result.FirstOrDefault()?.RecordCount + "", out TotalPages);
            }
            rptProcess.DataBind();
            RecordCount = TotalPages;
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
                var frontOfcList = DataProviderWrapper.Instance.GetReturnsByJobStatus("FO", PageNumber, PageSize, SearchText);
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

            BindData(PageNumber, PageSize, SearchText);
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
            string fileName = DateTime.Now.Date.ToString("MM/dd/yyyy") + "_Process_FrontOfficeReturns.csv";

            List<ProcessReturnsCL> processList = new List<ProcessReturnsCL>();
            var frontOfcList = DataProviderWrapper.Instance.GetReturnsByJobStatus("FO", PageNumber, PageSize, SearchText);

            if (frontOfcList.Count > 0)
            {
                strwriter.WriteLine("\"Sr.No\",\"NameOfSupervisor\",\"Priority\",\"JobNo\",\"TAN\",\"AccountName\",\"FinancialYear\",\"FormType\",\"Quarter\",\"ReturnType\"");
                int i = 0;
                foreach (RepeaterItem item in rptProcess.Items)
                {
                    ProcessReturnsCL itemProcess = new ProcessReturnsCL();
                    HiddenField hfId = (HiddenField)item.FindControl("hfId");
                    //Label lblSrno = (Label)item.FindControl("lblSrno");
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
                            string Srno = (++i).ToString(); //lblSrno.Text;
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
            
            string SearchText = txtSearch.Text.Trim();

            BindData(CurrentPageNo, PageSize, SearchText);
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

            string fileName = DateTime.Now.Date.ToString("MM/dd/yyyy") + "_Process_FrontOfficeReturns.pdf";
            string filePath = Path.Combine(Server.MapPath("~/PDFFiles"), fileName);
            var normalFont = FontFactory.GetFont(FontFactory.HELVETICA, 12);
            var boldFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 12);

            Document doc = new Document(iTextSharp.text.PageSize.A4.Rotate(), 1, 1, 1, 1);
            Paragraph p = new Paragraph("Process - FrontOffice Return", boldFont);
            p.Alignment = Element.ALIGN_CENTER;
            p.PaddingTop = 10f;
            p.SpacingAfter = 20f;
            p.SpacingBefore = 20f;

            try
            {
                PdfWriter.GetInstance(doc, new FileStream(filePath, FileMode.Create));
                PdfPTable pdfTab = new PdfPTable(10);
                pdfTab.SpacingBefore = 0f;
                pdfTab.SpacingAfter = 0f;

                var processList = DataProviderWrapper.Instance.GetReturnsByJobStatus("FO", PageNumber, PageSize, SearchText);

                if (processList.Count > 0)
                {
                    pdfTab.AddCell(new PdfPCell(new Paragraph("Sr.No", boldFont)));
                    pdfTab.AddCell(new PdfPCell(new Paragraph("NameOfSupervisor", boldFont)));
                    pdfTab.AddCell(new PdfPCell(new Paragraph("Priority", boldFont)));
                    pdfTab.AddCell(new PdfPCell(new Paragraph("JobNo", boldFont)));
                    pdfTab.AddCell(new PdfPCell(new Paragraph("TAN", boldFont)));
                    pdfTab.AddCell(new PdfPCell(new Paragraph("AccountName", boldFont)));
                    pdfTab.AddCell(new PdfPCell(new Paragraph("FinancialYear", boldFont)));
                    pdfTab.AddCell(new PdfPCell(new Paragraph("FormType", boldFont)));
                    pdfTab.AddCell(new PdfPCell(new Paragraph("Quarter", boldFont)));
                    pdfTab.AddCell(new PdfPCell(new Paragraph("ReturnType", boldFont)));
                    int i = 0;
                    foreach (RepeaterItem item in rptProcess.Items)
                    {
                        ProcessReturnsCL itemProcess = new ProcessReturnsCL();
                        HiddenField hfId = (HiddenField)item.FindControl("hfId");
                        //Label lblSrno = (Label)item.FindControl("lblSrno");
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
                                string Srno = (++i).ToString(); //lblSrno.Text;
                                string AccountName = lblAccountName.Text;
                                string TAN = lblTAN.Text;
                                string FinancialYear = lblFinancialYear.Text;
                                string FormNumber = lblFormNumber.Text;
                                string Quarter = lblQuarter.Text;
                                string ReturnType = lblReturnType.Text;

                                pdfTab.AddCell(Srno.ToString());
                                pdfTab.AddCell(SupervisorName.ToString());
                                pdfTab.AddCell(Prioritytype.ToString());
                                pdfTab.AddCell(JobNo.ToString());
                                pdfTab.AddCell(TAN.ToString());
                                pdfTab.AddCell(AccountName.ToString());
                                pdfTab.AddCell(FinancialYear.ToString());
                                pdfTab.AddCell(FormNumber.ToString());
                                pdfTab.AddCell(Quarter.ToString());
                                pdfTab.AddCell(ReturnType.ToString());
                            }
                        }
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