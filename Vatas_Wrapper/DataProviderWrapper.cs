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
        public bool AddUpdateUser(UserRegistrationCL user)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).AddUpdateUser(user);
            }
        }
        public List<UserRegistrationCL> GetAllRegisterdUser()
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).GetAllRegisterdUsers();
            }
        }
        public UserRegistrationCL GetRegisterdUserByUserId(int UserId)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).GetRegisterdUserByUserId(UserId);
            }
        }
        public bool DeleteRegisteredUser(int UserId)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).DeleteRegisteredUser(UserId);
            }
        }

        #region Reports

        public List<ReturnsCL> Report_GetReturnsByJobStatus(string JobStatus, char IsSent, int PageNumber, int PageSize)
        {
            using (VatasSolutionEntities context = new VatasSolutionEntities())
            {
                return BLReports.Instance(context).Report_GetReturnsByJobStatus(JobStatus, IsSent, PageNumber, PageSize);
            }
        }

        public List<ReturnsCL> Report_SearchJobsBetweenDates(DateTime startDate, DateTime endDate, int? firmId, int PageNumber, int PageSize)
        {
            using (VatasSolutionEntities context = new VatasSolutionEntities())
            {
                return BLReports.Instance(context).Report_SearchJobsBetweenDates(startDate, endDate, firmId, PageNumber, PageSize);
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

        public List<ProcessReturnsCL> GetReturnsByJobStatus(string StatusName, int PageNumber, int PageSize)
        {
            using (VatasSolutionEntities context = new VatasSolutionEntities())
            {
                return BLProcess.Instance(context).GetReturnsByJobStatus(StatusName, PageNumber, PageSize);
            }
        }

        public StringMessageCL ProcessReturns(List<ProcessReturnsCL> returns, int UserID, string IsSent = "Y")
        {
            using (VatasSolutionEntities context = new VatasSolutionEntities())
            {
                return BLProcess.Instance(context).ProcessReturns(returns, UserID, IsSent);
            }
        }

        #endregion

    }
}
