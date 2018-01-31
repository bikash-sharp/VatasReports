using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel.Web;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using Vatas_Common;
using Vatas_Wrapper;

namespace Vatas_Services
{
    /// <summary>
    /// Summary description for ReportService
    /// </summary>
    //[WebService]
    //[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [ScriptService]
    public class ReportService : System.Web.Services.WebService
    {
        [WebMethod(BufferResponse = false, EnableSession = true)]
        public string GetReturnDetails(string TAN, string Quarter, string FY, string FormNo, string RetType, long MasterID)
        {
            ReturnDetailCL result = new ReturnDetailCL();
            try
            {
                result = DataProviderWrapper.Instance.GetReturnDetail(TAN, Quarter, FY, FormNo, RetType, MasterID);
            }
            catch (Exception ex)
            {

            }
            string jsonResult = JsonConvert.SerializeObject(result,Formatting.Indented);
            return jsonResult;
        }
    }
}
