using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using Vatas_Common;
using Vatas_Wrapper;

namespace Vatas_UI.WebHandler
{
    /// <summary>
    /// Summary description for FileDownload
    /// </summary>
    public class FileDownload : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            long Id = 0;
            string DocumentId = BLSecurity.Decrypt(context.Request.QueryString["id"]);
            long.TryParse(DocumentId, out Id);
            try
            {
                if (Id != 0)
                {
                    var DocDetails = DataProviderWrapper.Instance.GetDocumentDetailById(Id);
                    if (DocDetails != null)
                    {
                        string Document = Path.Combine(DocDetails.FolderPath, DocDetails.FileName);
                        FileInfo fileInfo = new FileInfo(Document);
                        if (fileInfo.Exists)
                        {
                            byte[] bytes = File.ReadAllBytes(Document);
                            context.Response.Clear();
                            context.Response.ContentType = "application/octet-stream";
                            context.Response.AddHeader("content-disposition", "attachment;filename=" + DocDetails.DisplayAs);
                            context.Response.BinaryWrite(bytes);
                            // This would be the ideal spot to collect some download statistics and / or tracking  
                            // also, you could implement other requests, such as delete the file after download  
                            context.Response.End();
                        }
                        else
                        {
                            context.Response.ContentType = "text/plain";
                            context.Response.Write("File not be found!");
                        }
                    }
                }
                else
                {
                    context.Response.ContentType = "text/plain";
                    context.Response.Write("Invalid Request");
                }
            }
            catch(Exception ex)
            {
                var err = ex;
                context.Response.ContentType = "text/plain";
                context.Response.Write("Request Error");
            }
            
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