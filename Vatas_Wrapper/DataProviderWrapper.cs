﻿using System;
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

        public bool IsEmailExist(string EmailId)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).IsEmailAlreadyExist(EmailId);
            }
        }
        public List<UserRegistrationCL> GetAllRegisterdUser(string isActive)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).GetAllRegisterdUsers(isActive);
            }
        }
        public UserRegistrationCL GetRegisterdUserByUserId(int UserId)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).GetRegisterdUserByUserId(UserId);
            }
        }
        public bool EnableDisableRegisteredUser(int UserId, string isActive)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).EnableDisableRegisteredUser(UserId,isActive);
            }
        }
        public List<DropDownCL> GetAllRoles()
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).GetAllRoles();
            }
        }
        public bool DeleteRoleByRoleId(int RoleId)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).DeleteRoleByRoleId(RoleId);
            }
        }

        public bool AddUpdateRole(int RoleId, string RoleName)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).AddUpdateRole(RoleId, RoleName);
            }
        }

        public bool IsRoleExist(string RoleName)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).IsRoleExist(RoleName);
            }
        }

        public List<MenuCL> GetMenuByRoleId(int RoleId)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).GetMenuByRoleId(RoleId);
            }
        }

        public bool DeleteUserMenuByMenuId(int RoleId,int MenuId)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).DeleteUserMenuByMenuId(RoleId,MenuId);
            }
        }

        public List<DropDownCL> GetAllMenu()
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).GetAllMenu();
            }
        }

        public bool AddMenuToUserMenuByRoleId(int RoleId, int MenuId)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).AddMenuToUserMenuByRoleId(RoleId, MenuId);
            }
        }

        public bool IsMenuAlreadyExistInUserMenu(int RoleId, int MenuId)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).IsMenuAlreadyExistInUserMenu(RoleId,MenuId);
            }
        }

        public bool DeleteMenuByMenuId(int MenuId)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).DeleteMenuByMenuId(MenuId);
            }
        }

        public bool IsMenuExist(string MenuName)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).IsMenuExist(MenuName);
            }
        }

        public bool AddUpdateMenu(int MenuId, string MenuName)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).AddUpdateMenu(MenuId, MenuName);
            }
        }

        #region Reports

        public List<ReturnsCL> Report_GetReturnsByJobStatus(string JobStatus, char IsSent, int PageNumber, int PageSize, string SearchText)
        {
            using (VatasSolutionEntities context = new VatasSolutionEntities())
            {
                return BLReports.Instance(context).Report_GetReturnsByJobStatus(JobStatus, IsSent, PageNumber, PageSize, SearchText);
            }
        }

        public List<ReturnsCL> Report_SearchJobsBetweenDates(DateTime startDate, DateTime endDate, int? firmId, int PageNumber, int PageSize,string SearchText)
        {
            using (VatasSolutionEntities context = new VatasSolutionEntities())
            {
                return BLReports.Instance(context).Report_SearchJobsBetweenDates(startDate, endDate, firmId, PageNumber, PageSize, SearchText);
            }
        }

        public List<DropDownCL> Report_GetAllFirmName()
        {
            using (VatasSolutionEntities context = new VatasSolutionEntities())
            {
                return BLReports.Instance(context).Report_GetAllFirmName();
            }
        }

        public List<PathCL> GetAllPath()
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLPath.Instance(context).GetAllPath();
            }
        }

        public bool IsPathAlreadyExist(PathCL path)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLPath.Instance(context).IsPathAlreadyExist(path);
            }
        }

        public bool AddUpdatePath(PathCL path)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLPath.Instance(context).AddUpdatePath(path);
            }
        }

        public List<DropDownCL> GetAllProject()
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLPath.Instance(context).GetAllProject();
            }
        }

        public bool IsProjectAlreadyExist(string projectName)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLPath.Instance(context).IsProjectAlreadyExist(projectName);
            }
        }

        public bool AddUpdateProject(int projectId,string projectName)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLPath.Instance(context).AddUpdateProject(projectId,projectName);
            }
        }

        public bool IsOldPasswordVaild(string EmailId,string OldPassword)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).IsOldPasswordVaild(EmailId,OldPassword);
            }
        }

        public bool UpdateNewPassword(string EmailId,string Password)
        {
            using (AdminEntities context = new AdminEntities())
            {
                return BLSiteUser.Instance(context).UpdateNewPassword(EmailId,Password);
            }
        }

        #endregion

        #region Process

        public List<ProcessReturnsCL> GetReturnsByJobStatus(string StatusName, int PageNumber, int PageSize, string SearchText = null)
        {
            using (VatasSolutionEntities context = new VatasSolutionEntities())
            {
                return BLProcess.Instance(context).GetReturnsByJobStatus(StatusName, PageNumber, PageSize, SearchText);
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
