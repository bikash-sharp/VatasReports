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

        #region Reports

        public List<ReturnsCL> ReturnsAtFrontPage()
        {
            using (VatasSolutionEntities context = new VatasSolutionEntities() )
            {
                return BLReports.Instance(context).ReturnsAtFrontPage();
            }
        }

        public List<ReturnsCL> ReturnsAssigned()
        {
            using (VatasSolutionEntities context = new VatasSolutionEntities())
            {
                return BLReports.Instance(context).ReturnsAssigned();
            }
        }

        public List<ReturnsCL> ReturnsCompleted()
        {
            using (VatasSolutionEntities context = new VatasSolutionEntities())
            {
                return BLReports.Instance(context).ReturnsCompleted();
            }
        }

        public List<ReturnsCL> ReturnsIncompleted()
        {
            using (VatasSolutionEntities context = new VatasSolutionEntities())
            {
                return BLReports.Instance(context).ReturnsIncompleted();
            }
        }
        public List<ReturnsCL> ReturnsUploaded()
        {
            using (VatasSolutionEntities context = new VatasSolutionEntities())
            {
                return BLReports.Instance(context).ReturnsUploaded();
            }
        }

        public List<ReturnsCL> ReturnsPending()
        {
            using (VatasSolutionEntities context = new VatasSolutionEntities())
            {
                return BLReports.Instance(context).ReturnsPending();
            }
        }

        public List<ReturnsCL> SearchJobsBetweenDates(DateTime startDate, DateTime endDate)
        {
            using (VatasSolutionEntities context = new VatasSolutionEntities())
            {
                return BLReports.Instance(context).SearchJobsBetweenDates(startDate,endDate);
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
