using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;
using Vatas_Common;
using Vatas_Wrapper;

namespace Vatas_UI.User
{
    public partial class UserForm : VatasWebPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindServices();
                long CustomerId = 0;
                long.TryParse(Convert.ToString(HttpContext.Current.Items["CustomerId"]), out CustomerId);
                long DocumentId = 0;
                long.TryParse(Convert.ToString(HttpContext.Current.Items["DocumentTableId"]), out DocumentId);
                hfCustomerId.Value = CustomerId.ToString();
                hfDocumentId.Value = DocumentId.ToString();
                if(DocumentId !=0)
                {
                    var DocDetails = DataProviderWrapper.Instance.GetDocumentById(DocumentId);
                    if(DocDetails != null)
                    {
                        ddlService.SelectedIndex = DocDetails.ServiceId;
                        ddlService.Enabled = false;
                        txtDocumentNotes.Text = DocDetails.DocumentNotes; txtDocumentNotes.Enabled = false;
                        txtDocumentTitle.Text = DocDetails.DocumentTitle; txtDocumentTitle.Enabled = false;

                    }
                }
                if (BLFunction.GetRoleName().ToLower() != "potentialuser" && BLFunction.GetRoleName().ToLower() != "associate" && BLFunction.GetRoleName().ToLower() != "superadmin")
                {
                    Response.RedirectToRoute("401");
                }
                else if ((BLFunction.GetRoleName().ToLower() == "associate" || BLFunction.GetRoleName().ToLower() == "superadmin" ) && CustomerId == 0)
                {
                    Response.RedirectToRoute("401");
                }
                
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            if (BLFunction.GetRoleName().ToLower() == "potentialuser")
            {
                BLFunction.ShowAlertRedirect(this, "This is will cancel the document upload", CurrentPagePath + "UserForm", ResponseType.WARNING);
            }
            else if (BLFunction.GetRoleName().ToLower() == "associate")
            {
                BLFunction.ShowAlertRedirect(this, "This is will cancel the document upload", CurrentPagePath + "Customers/" + hfCustomerId.Value, ResponseType.WARNING);
            }
            else if (BLFunction.GetRoleName().ToLower() == "superadmin")
            {
                BLFunction.ShowAlertRedirect(this, "This is will cancel the document upload", CurrentPagePath + "Customers/" + hfCustomerId.Value, ResponseType.WARNING);
            }

        }

        public void BindServices()
        {
            var ServiceList = DataProviderWrapper.Instance.GetAllServices();
            ddlService.DataSource = ServiceList;
            ddlService.DataTextField = "DataText";
            ddlService.DataValueField = "DataValue";
            ddlService.DataBind();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                
                var fileList = HttpContext.Current.Session["userUploadFiles"] as List<FileUploadCL>;
                if (fileList != null)
                {
                    if (fileList.Count > 0)
                    {
                        List<FileUploadCL> DocumentFiles = new List<FileUploadCL>();
                        string DocumentId = BLFunction.GenerateDocumentId();
                        long DocumentTableId = 0;
                        long.TryParse(hfDocumentId.Value, out DocumentTableId);
                        var DocDetails = DataProviderWrapper.Instance.GetDocumentById(DocumentTableId);
                        if (DocDetails != null)
                            DocumentId = DocDetails.DocumentId;
                        String TempDir = Path.Combine(new string[] { BLFunction.UserDocumentDirectoryPath(), "temp", DateTime.Now.ToString("ddMMyyyy"), HttpContext.Current.Session.SessionID });
                        string DestDir = "";
                        if (BLFunction.GetRoleName().ToLower() == "potentialuser")
                        {
                            DestDir = Path.Combine(new string[] { BLFunction.UserDocumentDirectoryPath(), BLFunction.GetUserID().ToString(), DocumentId });
                        }
                        else if (BLFunction.GetRoleName().ToLower() == "associate")
                        {
                            DestDir = Path.Combine(new string[] { BLFunction.UserDocumentDirectoryPath(), BLFunction.GetUserID().ToString(), hfCustomerId.Value, DocumentId });
                        }


                        DirectoryInfo directoryInfo = new DirectoryInfo(DestDir);
                        if (!directoryInfo.Exists)
                            directoryInfo.Create();
                        foreach (var item in fileList)
                        {
                            string SrcFile = Path.Combine(TempDir, item.fileName);
                            string DestFile = Path.Combine(DestDir, item.fileName);
                            File.Move(SrcFile, DestFile);

                            DocumentFiles.Add(new FileUploadCL() { fileName = item.fileName, displayAs = item.displayAs, folderpath = DestDir });
                        }
                        int ServiceId = 0;
                        int.TryParse(ddlService.SelectedValue, out ServiceId);
                        //Document Table
                        if(DocumentTableId == 0)
                        {
                            if (BLFunction.GetRoleName().ToLower() == "potentialuser")
                            {
                                DocumentTableId = DataProviderWrapper.Instance.SaveDocument(BLFunction.GetUserID(), ServiceId, DocumentId, txtDocumentTitle.Text.Trim(), txtDocumentNotes.Text.Trim(), false);
                            }
                            else if (BLFunction.GetRoleName().ToLower() == "associate")
                            {
                                DocumentTableId = DataProviderWrapper.Instance.SaveDocument(int.Parse(hfCustomerId.Value), ServiceId, DocumentId, txtDocumentTitle.Text.Trim(), txtDocumentNotes.Text.Trim(), false, true);
                            }
                        }
                        
                        if (DocumentTableId != 0)
                        {
                            
                            
                            //Save Files and Folder Path also
                            bool IsDocumentFilesSaved = DataProviderWrapper.Instance.SaveDocumentFiles(DocumentTableId, DocumentFiles);
                            //Insert Default Document Status
                            DocumentStatusDetailCL documentStatusDetail = new DocumentStatusDetailCL();
                            if (BLFunction.GetRoleName().ToLower() == "potentialuser")
                            {
                                documentStatusDetail.AssociateId = 0;
                                documentStatusDetail.PotentialUserId = BLFunction.GetUserID();
                            }
                            else if (BLFunction.GetRoleName().ToLower() == "associate")
                            {
                                documentStatusDetail.PotentialUserId = 0;
                                documentStatusDetail.AssociateId = BLFunction.GetUserID();
                            }
                            documentStatusDetail.SupervisorId = documentStatusDetail.StaffId = 0;
                            documentStatusDetail.IsChecked = false;
                            documentStatusDetail.DocumentId = DocumentId;
                            documentStatusDetail.DocumentStatusId = 1; //Received Status by Default

                            long DocumentStatusId = DataProviderWrapper.Instance.InsertDocumentStatusDetails(documentStatusDetail);
                        }

                        if (DocumentTableId > 0)
                        {
                            if (BLFunction.GetRoleName().ToLower() == "potentialuser")
                            {
                                BLFunction.ShowAlertRedirect(this, "Your document has been uploaded successfully. Our customer representative will contact you within 48hr.", CurrentPagePath + "UserForm", ResponseType.WARNING);
                            }
                            else if (BLFunction.GetRoleName().ToLower() == "associate")
                            {
                                BLFunction.ShowAlertRedirect(this, "Your document has been uploaded successfully. Our customer representative will contact you within 48hr.", CurrentPagePath + "Customers/" + hfCustomerId.Value, ResponseType.WARNING);
                            }
                        }
                        else
                        {
                            BLFunction.ShowAlert(this, "Unable To upload the files on server.", ResponseType.WARNING);
                        }
                    }
                    else
                    {
                        BLFunction.ShowAlert(this, "Please upload atleast one document.", ResponseType.WARNING);
                    }
                }
                else
                {
                    BLFunction.ShowAlert(this, "Please upload atleast one document.", ResponseType.WARNING);
                }

            }
            catch (Exception)
            {
                BLFunction.ShowAlert(this, "Server Error Occurred.", ResponseType.DANGER);
            }

        }


        [WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<FileUploadCL> DeleteFile(string filename)
        {
            string directoryPath = Path.Combine(new string[] { BLFunction.UserDocumentDirectoryPath(), "temp", DateTime.Now.ToString("ddMMyyyy"), HttpContext.Current.Session.SessionID });
            string filePath = Path.Combine(directoryPath, filename);
            FileInfo fileInfo = new FileInfo(filePath);
            if (fileInfo.Exists)
                fileInfo.Delete();
            var fileList = HttpContext.Current.Session["userUploadFiles"] as List<FileUploadCL>;
            HttpContext.Current.Session["userUploadFiles"] = fileList.Where(p => p.fileName != filename).ToList();
            return HttpContext.Current.Session["userUploadFiles"] as List<FileUploadCL>;

        }


    }
}