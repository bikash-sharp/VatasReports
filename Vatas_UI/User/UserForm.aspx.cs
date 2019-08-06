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
                if (BLFunction.GetRoleName().ToLower() != "potentialuser")
                {
                    Response.RedirectToRoute("401");
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            BLFunction.ShowAlertRedirect(this, "This is will cancel the document upload", CurrentPagePath + "UserForm", ResponseType.WARNING);
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
                        string DocumentId = BLFunction.GenerateDocumentId();
                        String TempDir = Path.Combine(new string[] { BLFunction.UserDocumentDirectoryPath(), "temp", DateTime.Now.ToString("ddMMyyyy"), HttpContext.Current.Session.SessionID });
                        string DestDir = Path.Combine(new string[] { BLFunction.UserDocumentDirectoryPath(), BLFunction.GetUserID().ToString(), DocumentId });
                        DirectoryInfo directoryInfo = new DirectoryInfo(DestDir);
                        if (!directoryInfo.Exists)
                            directoryInfo.Create();
                        foreach (var item in fileList)
                        {
                            string SrcFile = Path.Combine(TempDir, item.fileName);
                            string DestFile = Path.Combine(DestDir, item.fileName);
                            File.Move(SrcFile, DestFile);
                        }
                        bool IsSaved = DataProviderWrapper.Instance.SaveDocument(BLFunction.GetUserID(), DocumentId, txtDocumentTitle.Text.Trim(), txtDocumentNotes.Text.Trim(), false);
                        if (IsSaved)
                        {
                            BLFunction.ShowAlertRedirect(this, "Your document has been uploaded successfully. Our customer representative will contact you within 48hr.", CurrentPagePath + "UserForm", ResponseType.SUCCESS);
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