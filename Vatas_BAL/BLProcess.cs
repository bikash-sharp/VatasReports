using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Vatas_Common;
using Vatas_DAL;

namespace Vatas_BAL
{
    public sealed class BLProcess
    {
        private static readonly BLProcess _instance;
        private static AdminEntities _admin;
        private static VatasSolutionEntities _vatasSolution;
        static BLProcess()
        {
            _instance = new BLProcess();
        }

        private BLProcess()
        {

        }

        /// <summary>
        /// creates object of the class
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public static BLProcess Instance(AdminEntities context)
        {
            _admin = context;
            return _instance;
        }

        public static BLProcess Instance(VatasSolutionEntities context)
        {
            _vatasSolution = context;
            return _instance;
        }

        public List<DropDownCL> getProcessPriorities()
        {
            return _vatasSolution.tbl_ProcessPriority.Select(p => new DropDownCL { DataText = p.Priority, DataValue = p.Priority_ID.ToString() }).ToList();
        }

        public List<DropDownCL> getProcessStatus()
        {
            return _vatasSolution.tbl_ProcessStatus.Select(p => new DropDownCL { DataText = p.Process_Name, DataValue = p.Process_Code.ToString() }).ToList();
        }

        public List<ProcessReturnsCL> GetReturnsByJobStatus(string StatusName, int PageNumber, int PageSize)
        {
            List<ProcessReturnsCL> result = new List<ProcessReturnsCL>();
            result = _vatasSolution.proc_Report_GetReturnsByJobStatus(StatusName, PageNumber, PageSize)
                .Select(p => new ProcessReturnsCL
                {
                    AccountName = p.AccountName,
                    FinancialYear = p.FinancialYear,
                    FormNumber = p.FormType,
                    JobNo = (p.JobNo.HasValue == true ? p.JobNo.Value : 0),
                    Quarter = p.Quarter,
                    ReturnType = p.ReturnType,
                    TAN = p.TAN,
                    JobID = p.JobID,
                    NextUserID = (p.UserID == null ? 0 : p.UserID.Value),
                    ReasonforReturn = p.Comments,
                    PRN = p.PRN,
                    SupervisorName = p.SuperVisorName,
                    RecordCount = p.RecordCount == null ? 0 : p.RecordCount.Value
                }).ToList();

            var priorities = getProcessPriorities();
            var processStatus = getProcessStatus();
            foreach (var item in result)
            {
                item.PriorityList = priorities;
                if (StatusName == "BO")
                    item.ProcessTypeList = processStatus.Where(p => p.DataValue == "RDV" || p.DataValue == "FO").ToList();
            }
            using (AdminEntities _admin = new AdminEntities())
            {
                var superVisiors = new List<DropDownCL>();
                if (StatusName == "FO")
                    superVisiors = BLSiteUser.Instance(_admin).GetUserRolesByRoleId((int)Roles.DataEntrySupervisor);
                else if (StatusName == "RDV")
                    superVisiors = BLSiteUser.Instance(_admin).GetUserRolesByRoleId((int)Roles.DataEntryOperator);
                else
                    superVisiors = BLSiteUser.Instance(_admin).GetUserRolesByRoleId((int)Roles.All);

                //A Site User can be have multiple Roles, We Need to Send the Distinct User List
                var UserList = new List<DropDownCL>();
                foreach (var _usrid in superVisiors.Select(p => p.DataValue).Distinct().ToList())
                {
                    var SelectedItem = superVisiors.FirstOrDefault(p => p.DataValue == _usrid);
                    if (SelectedItem != null)
                    {
                        UserList.Add(SelectedItem);
                    }
                }

                foreach (var item in result)
                {
                    item.SupervisorList = UserList;
                }
            }
            return result;
        }

        public StringMessageCL ProcessReturns(List<ProcessReturnsCL> returns, int UserID, string IsSent = "Y")
        {
            var result = new StringMessageCL();
            try
            {
                foreach (var item in returns)
                {
                    var selectedItem = _vatasSolution.tbl_ProcessesHistoryofjob.FirstOrDefault(p => p.ID == item.JobID);
                    //Update Existing
                    selectedItem.Is_Sent = IsSent;

                    _vatasSolution.tbl_ProcessesHistoryofjob.Add(new tbl_ProcessesHistoryofjob
                    {
                        Is_Sent = "",
                        Job_Status = item.CurrentJobStatus,
                        MasterID = selectedItem.MasterID,
                        Previous_UserID = selectedItem.Previous_UserID == 0 ? UserID : selectedItem.Previous_UserID,
                        Next_UserID = item.NextUserID == 0 ? selectedItem.Next_UserID : item.NextUserID,
                        Priority_of_Job = item.PriorityID == 0 ? selectedItem.Priority_of_Job : item.PriorityID,
                        Supervisor = String.IsNullOrEmpty(item.SupervisorName) == true ? selectedItem.Supervisor : item.SupervisorName,
                        Reason_for_Delay = String.IsNullOrEmpty(item.ReasonforReturn) == true ? selectedItem.Reason_for_Delay : item.ReasonforReturn,
                        Date_Time_Stamp = DateTime.Now.ToString(),
                    });
                    _vatasSolution.SaveChanges();

                }
                result = new StringMessageCL("Success", ResponseType.SUCCESS);
            }
            catch (Exception ex)
            {
                // ignored
                var error = ex.InnerException;
                result = new StringMessageCL("Failed", ResponseType.DANGER);
            }
            return result;
        }
    }
}
