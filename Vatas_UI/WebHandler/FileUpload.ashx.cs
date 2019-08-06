using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.SessionState;
using Vatas_Common;

namespace Vatas_UI.WebHandler
{
    /// <summary>
    /// Summary description for FileUpload
    /// </summary>
    public class FileUpload : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            List<FileUploadCL> fileList = new List<FileUploadCL>();
            string directoryPath = Path.Combine(new string[] { BLFunction.UserDocumentDirectoryPath(),"temp" ,DateTime.Now.ToString("ddMMyyyy"), HttpContext.Current.Session.SessionID });
          
            DirectoryInfo directoryInfo = new DirectoryInfo(directoryPath);
            if (!directoryInfo.Exists)
            {
                directoryInfo.Create();
            }
            try
            {
                if (context.Request.Files.Count > 0)
                {
                    HttpFileCollection fileCollection = context.Request.Files;
                    for (int i = 0; i < fileCollection.Count; i++)
                    {
                        HttpPostedFile file = fileCollection[i];
                        string fileName = Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
                        string filePath = Path.Combine(directoryPath, fileName);
                        file.SaveAs(filePath);
                        fileList.Add(new FileUploadCL() { fileName = fileName, filePath = filePath });

                        
                    }
                }
            }
            catch (Exception ex)
            {
                var err = ex.Message;
            }
            var json = JsonConvert.SerializeObject(fileList);
            HttpContext.Current.Session["userUploadFiles"] = fileList;
            context.Response.ContentType = "text/json";
            context.Response.Write(json);
            context.Response.Expires = -1;
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}