using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using Vatas_Common;
using Vatas_Wrapper;

namespace Vatas_UI.Associate
{
    public partial class CreateUser : VatasWebPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (BLFunction.GetRoleName().ToLower() != "associate")
                {
                    Response.RedirectToRoute("401");
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                var fileList = HttpContext.Current.Session["userUploadFiles"] as List<FileUploadCL>;
                if(fileList != null)
                {
                    if (fileList.Count > 0)
                    {
                        int UserAssociateId = 0;
                        UserAssociateId = DataProviderWrapper.Instance.SaveAssociateUser(0, BLFunction.GetUserID(), txtFirstName.Text.Trim(), txtLastName.Text.Trim(), txtEmail.Text.Trim(), txtMobileNumber.Text.Trim(), null);
                        if (UserAssociateId > 0)
                        {
                            string DocumentId = BLFunction.GenerateDocumentId();
                            String TempDir = Path.Combine(new string[] { BLFunction.UserDocumentDirectoryPath(), "temp", DateTime.Now.ToString("ddMMyyyy"), HttpContext.Current.Session.SessionID });
                            string DestDir = Path.Combine(new string[] { BLFunction.UserDocumentDirectoryPath(), BLFunction.GetUserID().ToString(), UserAssociateId.ToString(), DocumentId });
                            DirectoryInfo directoryInfo = new DirectoryInfo(DestDir);
                            if (!directoryInfo.Exists)
                                directoryInfo.Create();
                            foreach (var item in fileList)
                            {
                                string SrcFile = Path.Combine(TempDir, item.fileName);
                                string DestFile = Path.Combine(DestDir, item.fileName);
                                File.Move(SrcFile, DestFile);
                            }
                            bool IsSaved = DataProviderWrapper.Instance.SaveDocument(UserAssociateId, DocumentId, txtDocumentTitle.Text.Trim(), txtDocumentNotes.Text.Trim(), false);
                            if (IsSaved)
                            {
                                BLFunction.ShowAlertRedirect(this, "Your document has been uploaded successfully. Our customer representative will contact you within 48hr.", CurrentPagePath + "NewUser", ResponseType.SUCCESS);
                            }
                            else
                            {
                                BLFunction.ShowAlert(this, "Unable To upload the files on server.", ResponseType.WARNING);
                            }
                        }
                        else
                        {
                            BLFunction.ShowAlert(this, "User Creation failed.Please try later.", ResponseType.WARNING);
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
    }
}