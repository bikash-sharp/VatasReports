using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Vatas_BAL;
using Vatas_Common;
using Vatas_DAL;

namespace Vatas_Wrapper
{
    public class DataProviderWrapper
    {
        private static readonly DataProviderWrapper instance = new DataProviderWrapper();
        //private static POSEntities context;

        static DataProviderWrapper() { }
        private DataProviderWrapper() { }

        public static DataProviderWrapper Instance
        {
            get
            {
                return instance;
            }
        }

        public AuthMessageCL CheckUserCredentials(string email, string password)
        {
            try
            {
                AuthMessageCL authDetails = new AuthMessageCL();
                LogonCL loginDetails = new LogonCL();
                using (AdminEntities context = new AdminEntities())
                {
                    loginDetails.Email = email.Trim();
                    loginDetails.Password = password.Trim();
                    authDetails = BLAuthentication.Instance(context).IsUserAuthenticated(loginDetails);
                }
                return authDetails;
            }
            catch (Exception ex)
            {
                var Msg = ex.Message + (ex.InnerException != null ? ex.InnerException.ToString() : "");
                return new AuthMessageCL(0, null, 0, null, "", ResponseType.DANGER, Msg);
            }
        }

        public bool SaveNewUser(User user)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).SaveNewUser(user);
            }
        }

        #region Reports

        public List<ReturnsCL> Report_GetReturnsByJobStatus(string JobStatus,char IsSent)
        {
            using (VatasSolutionEntities context = new VatasSolutionEntities())
            {
                return BLReports.Instance(context).Report_GetReturnsByJobStatus(JobStatus, IsSent);
            }
        }

        public List<ReturnsCL> Report_SearchJobsBetweenDates(DateTime startDate, DateTime endDate,int? firmId)
        {
            using (VatasSolutionEntities context = new VatasSolutionEntities())
            {
                return BLReports.Instance(context).Report_SearchJobsBetweenDates(startDate,endDate, firmId);
            }
        }

        public List<DropDownCL> Report_GetAllFirmName()
        {
            using (VatasSolutionEntities context = new VatasSolutionEntities())
            {
                return BLReports.Instance(context).Report_GetAllFirmName();
            }
        }
        #endregion

        #region Process

        public List<ProcessReturnsCL> GetReturnsByJobStatus(string StatusName)
        {
            using (VatasSolutionEntities context = new VatasSolutionEntities())
            {
                return BLProcess.Instance(context).GetReturnsByJobStatus(StatusName);
            }
        }

        public StringMessageCL ProcessReturns(List<ProcessReturnsCL> returns, int UserID)
        {
            using (VatasSolutionEntities context = new VatasSolutionEntities())
            {
                return BLProcess.Instance(context).ProcessReturns(returns, UserID);
            }
        }
        
        #endregion
        }
}
