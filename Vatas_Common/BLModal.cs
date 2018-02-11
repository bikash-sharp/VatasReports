using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;

namespace Vatas_Common
{
    #region CommonSection
    public class DropDownCL
    {
        public string SelectedValue { get; set; }
        public string DataText { get; set; }
        public string DataValue { get; set; }
        public DropDownCL() { }
    }

    public class StringMessageCL
    {
        public string Message { get; set; }
        public string RetValue { get; set; }
        public ResponseType Response { get; set; }
        public long IntValue { get; set; }
        public dynamic ObjClass { get; set; }
        public StringMessageCL() { }
        public StringMessageCL(string message, ResponseType response, string retValue = "", long intValue = 0, dynamic objValue = null)
        {
            Message = message;
            Response = response;
            RetValue = retValue;
            IntValue = intValue;
            ObjClass = objValue;
        }
    }
    #endregion

    #region UserAuthSection
    public class AuthMessageCL
    {
        public long UserID { get; set; }

        public string UserName { get; set; }

        public long RoleID { get; set; }

        public string RoleName { get; set; }

        public ResponseType Resp { get; set; }

        public string Message { get; set; }

        public string Token { get; set; }

        public AuthMessageCL() { }

        public AuthMessageCL(long userID, string userName, long roleID, string roleName, string token, ResponseType resp, string message)
        {
            UserID = userID;
            UserName = userName;
            RoleID = roleID;
            RoleName = roleName;
            Resp = resp;
            Message = message;
            Token = token;
        }
    }

    public class LogonCL
    {

        public string UserName { get; set; }

        public string Password { get; set; }

        public string Email { get; set; }
        public LogonCL() { }
    }

    public class RoleCL
    {
        public long RoleId { get; set; }
        public string RoleName { get; set; }

        public RoleCL() { }
    }

    public class FirmCL
    {
        public FirmCL() { }
        public long FirmId { get; set; }
        public string FirmName { get; set; }
        public bool IsActive { get; set; }
    }
    #endregion

    #region ReturnsSection
    public class ReturnsCL
    {
        public string FirmName { get; set; }
        public long JobNo { get; set; }
        public string TAN { get; set; }
        public string AccountName { get; set; }
        public string FinancialYear { get; set; }
        public string FormType { get; set; }
        public string Quarter { get; set; }
        public string ReturnType { get; set; }
        public string Date { get; set; }
        public string AssignedDate { get; set; }
        public string Username { get; set; }
        public int RecordCount { get; set; }
    }
    public class ReturnDetailCL
    {
        public decimal TaxDeducted { get; set; }
        public decimal TaxDeposited { get; set; }
        public decimal AmountPaid { get; set; }
        public int DeducteeCount { get; set; }
        public string TAN { get; set; }
        public string FY { get; set; }
        public string Quarter { get; set; }
        public string FormNo { get; set; }
        public string ReturnType { get; set; }
        public long MasterID { get; set; }
        public ReturnDetailCL()
        {
            TaxDeducted = TaxDeposited = AmountPaid= DeducteeCount = 0;
        }
    }
    #endregion

    #region ProcessList

    public class ProcessReturnsCL
    {
        public List<DropDownCL> SupervisorList { get; set; }
        public int SupervisorID { get; set; }
        public string SupervisorName { get; set; }
        public List<DropDownCL> PriorityList { get; set; }
        public int PriorityID { get; set; }
        public string Prioritytype { get; set; }
        public long JobNo { get; set; }
        public string AccountName { get; set; }
        public string TAN { get; set; }
        public string FinancialYear { get; set; }
        public string ReturnType { get; set; }
        public string Quarter { get; set; }
        public string FormNumber { get; set; }
        public string PRN { get; set; }
        public int JobID { get; set; }
        public List<DropDownCL> ProcessTypeList { get; set; }
        public string ReasonforReturn { get; set; }
        public string CurrentJobStatus { get; set; }
        public long? NextUserID { get; set; }
        public string AssignedUser { get; set; }
        public string AssignedByUser { get; set; }
        public long MasterID { get; set; }
        public ProcessReturnsCL()
        {
            SupervisorList = new List<DropDownCL>();
            PriorityList = new List<DropDownCL>();
            ProcessTypeList = new List<DropDownCL>();
        }
        public int RecordCount { get; set; }
    }
    #endregion

    #region UserSection
    public class UserCL
    {
        public int UserID { get; set; }
        public string Username { get; set; }
        public int RoleId { get; set; }
        public string RoleName { get; set; }
        public UserCL() { }
    }
    public class UserRegistrationCL
    {
        public int UserId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string ConfirmPassword { get; set; }
        public string Address { get; set; }
        public string Country { get; set; }
        public int State { get; set; }
        public string City { get; set; }
        public int PinCode { get; set; }
        public string MobileNumber { get; set; }
        public int STDCode { get; set; }
        public string Telephone { get; set; }
        public string OrganizationName { get; set; }
        public string SecurityQuestion { get; set; }
        public string Answer { get; set; }
        public string SelectPackage { get; set; }
        public string ActivationCode { get; set; }
        public char Status { get; set; }
        public string JoinDate { get; set; }
        public string AccountType { get; set; }
        public string IsActive { get; set; }
        public int AdminId { get; set; }
        public int RoleId { get; set; }
        public string RoleName { get; set; }
        public int MenuId { get; set; }
        public string MenuName { get; set; }
    }
    #endregion

    #region MenuSection
    public class MenuCL
    {
        public int MenuID { get; set; }
        public string MenuName { get; set; }
        public int MenuLevel { get; set; }
        public string MenuLink { get; set; }
        public int MenuStatus { get; set; }
        public string ProjectName { get; set; }
        public int MenuOrder { get; set; }
    }
    #endregion

    #region ProjectPathSection
    public class PathCL
    {
        public int PathID { get; set; }
        public string PathName { get; set; }
        public string Host { get; set; }
        public string Path { get; set; }
        public string PathProject { get; set; }
    }

    public class ProjectCL
    {
        public int ProjectId { get; set; }
        public string ProjectName { get; set; }
    }
    #endregion

    #region Folder&Files
    public class FilesCL
    {
        public string fileName { get; set; }
        public string FileLocation { get; set; }
    }
    #endregion

}
