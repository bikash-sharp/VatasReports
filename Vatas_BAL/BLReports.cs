using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Vatas_Common;
using Vatas_DAL;

namespace Vatas_BAL
{
    public sealed class BLReports
    {
        private static readonly BLReports _instance;
        private static AdminEntities _admin;
        private static VatasSolutionEntities _vatasSolution;
        static BLReports()
        {
            _instance = new BLReports();
        }

        private BLReports()
        {

        }

        /// <summary>
        /// creates object of the class
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public static BLReports Instance(AdminEntities context)
        {
            _admin = context;
            return _instance;
        }

        public static BLReports Instance(VatasSolutionEntities context)
        {
            _vatasSolution = context;
            return _instance;
        }

        //public List<ReturnsCL> ReturnsAtFrontPage()
        //{
        //    List<ReturnsCL> result = new List<ReturnsCL>();
        //    try
        //    {
        //        result =
        //            _vatasSolution.proc_ReturnsAtFrontOffice()
        //                .ToList()
        //                .Select(p => new ReturnsCL
        //                {
        //                    AccountName = p.AccountName,
        //                    FinancialYear=p.FinancialYear,
        //                    Date=p.JobDate,
        //                    FirmName=p.FirmName,
        //                    FormType=p.FormType,
        //                    Quarter=p.Quarter,
        //                    ReturnType=p.ReturnType,
        //                    TAN=p.TAN,
        //                    JobNo= (p.Job_No != null ? p.Job_No.Value : 0)
        //    }).ToList();
        //    }
        //    catch(Exception ex)
        //    {
        //        var error = ex.Message;
        //    }
        //    return result;
        //}

        public List<ReturnsCL> Report_GetReturnsByJobStatus(string JobStatus,char IsSent)
        {
            List<ReturnsCL> result = new List<ReturnsCL>();
            try
            {
                result =
                    _vatasSolution.proc_Report_GetReturnsByJobStatus(JobStatus)
                        .ToList()
                        .Select(p => new ReturnsCL
                        {
                            AccountName = p.AccountName,
                            FinancialYear = p.FinancialYear,
                            Date = p.JobDate,
                            FirmName = p.FirmName,
                            FormType = p.FormType,
                            Quarter = p.Quarter,
                            ReturnType = p.ReturnType,
                            TAN = p.TAN,
                            JobNo = (p.Job_No != null ? p.Job_No.Value : 0),
                            AssignedDate = p.AssignedDate,
                            Username = (p.UserID != null ? p.UserID.Value.ToString() : "0")
                        }).ToList();

                if (result.Count > 0)
                {
                    using (AdminEntities context = new AdminEntities())
                    {
                        var userlist = BLSiteUser.Instance(context).GetAllUsers();
                        foreach (var item in result)
                        {
                            var user = userlist.FirstOrDefault(p => (p.UserID == int.Parse(item.Username)));
                            if (user != null)
                                item.Username = user.Username;
                            else
                                item.Username = "user";
                        }

                    }
                }
            }
            catch (Exception ex)
            {
                var error = ex.Message;
            }
            return result;
        }

        public List<ReturnsCL> Report_SearchJobsBetweenDates(DateTime startDate, DateTime endDate)
        {
            List<ReturnsCL> result = new List<ReturnsCL>();
            try
            {
                result =
                    _vatasSolution.proc_Report_SearchJobsBetweenDates(startDate,endDate)
                        .ToList()
                        .Select(p => new ReturnsCL
                        {
                            AccountName = p.AccountName,
                            FinancialYear = p.FinancialYear,
                            Date = p.JobDate,
                            FirmName = p.FirmName,
                            FormType = p.FormType,
                            Quarter = p.Quarter,
                            ReturnType = p.ReturnType,
                            TAN = p.TAN,
                            JobNo = (p.Job_No != null ? p.Job_No.Value : 0)
                        }).ToList();
            }
            catch (Exception ex)
            {
                var error = ex.Message;
            }
            return result;
        }
    }
}
