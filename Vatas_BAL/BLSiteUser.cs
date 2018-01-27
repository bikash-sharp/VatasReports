using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using Vatas_Common;
using Vatas_DAL;

namespace Vatas_BAL
{
    public sealed class BLSiteUser : BLCommon
    {
        private static readonly BLSiteUser _instance;
        private static AdminEntities _context;

        static BLSiteUser()
        {
            _instance = new BLSiteUser();
        }

        private BLSiteUser()
        {

        }

        /// <summary>
        /// creates object of the class
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public static BLSiteUser Instance(AdminEntities context)
        {
            _context = context;
            return _instance;
        }

        public StringMessageCL GetSiteUserIDByUserNameOREmailAddress(string identity)
        {
            try
            {
                var _user =
                    _context.tbl_UserGroup_Registration.Where(p => (p.EmailID.ToLower() == identity.ToLower()))
                        .FirstOrDefault();

                if (_user != null)
                {
                    return new StringMessageCL("Register User found", ResponseType.SUCCESS, "Success",
                        _user.Super_User_Id, _user);
                }
                else
                {
                    return
                        new StringMessageCL(
                            "User not found.Please verify the Username / Email and password once again",
                            ResponseType.DANGER, "", 0);
                }
            }
            catch (DbEntityValidationException ex)
            {
                return new StringMessageCL(ex.InnerException.Message, ResponseType.DANGER, "", 0);
            }
            catch (Exception ex)
            {
                return new StringMessageCL(ex.InnerException.Message, ResponseType.DANGER, "", 0);
            }

        }

        public tbl_UserGroup_Registration GetSiteUserByID(long userID)
        {
            return _context.tbl_UserGroup_Registration.Where(p => p.Super_User_Id == userID).FirstOrDefault();
        }

        public List<UserCL> GetAllUsers()
        {
            return
                _context.tbl_UserGroup_Registration.ToList()
                    .Select(p => new UserCL { UserID = p.Super_User_Id, Username = p.Name })
                    .ToList();
        }

        public List<DropDownCL> GetUserRolesByRoleId(int RoleId)
        {
            return _context.proc_GetUserRoleByRoleId(RoleId)
                    .Select(p => new DropDownCL { DataText = p.UserName, DataValue = p.UserID.ToString() })
                    .ToList();
        }

        public List<UserCL> GetUserRolesByUserId(int UserId)
        {
            List<UserCL> result = new List<UserCL>();
            try
            {
                return _context.proc_GetUserRoleByUserId(UserId)
                    .Select(p => new UserCL { UserID = p.UserID ?? 0, Username = p.UserName, RoleId = p.RoleId ?? 0, RoleName = p.Role_Name })
                    .ToList();
            }
            catch (Exception ex)
            {
                var err = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// Save New User with User Details
        /// </summary>
        /// <param name="User"></param>
        /// <returns>user saved or not</returns>
        public bool AddUpdateUser(UserRegistrationCL user)
        {
            try
            {
                _context.proc_AddUpdateUser(user.UserId, user.FirstName, user.LastName, user.Email, user.Password, user.MobileNumber, user.AccountType, user.RoleId, user.IsActive);
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        /// <summary>
        /// check emailid is already exist or not
        /// </summary>
        /// <param name="emailId"></param>
        /// <returns>user saved or not</returns>
        public bool IsEmailAlreadyExist(string emailId)
        {
            try
            {
                var result = _context.tbl_UserGroup_Registration.Where(s => s.EmailID.ToLower() == emailId.ToLower().Trim()).FirstOrDefault();
                if (result != null)
                    return true;
                else
                    return false;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        /// <summary>
        /// Get all the registered user from Tbl_UserRegistration 
        /// </summary>
        /// <param></param>
        /// <returns>List<UserRegistrationCL> list of users</returns>
        public List<UserRegistrationCL> GetAllRegisterdUsers(string isActive)
        {
            List<UserRegistrationCL> users = new List<UserRegistrationCL>();
            try
            {
                users = _context.proc_GetAllRegisteredUsers(isActive).ToList()
                     .Select(p =>
                         new UserRegistrationCL
                         {
                             UserId = p.UserId,
                             FirstName = p.FirstName,
                             LastName = p.LastName,
                             Email = p.Email,
                             Password = p.Password,
                             MobileNumber = p.MobileNumber,
                             OrganizationName = p.OrganizationName,
                             AccountType = p.AccountType,
                             IsActive = p.IsActive,
                             RoleId = p.RoleId,
                             RoleName = p.RoleName
                         }).ToList();

                return users;
            }
            catch (Exception ex)
            {
                return users;
            }
        }

        /// <summary>
        /// Get the registered user by userid
        /// </summary>
        /// <param>userid</param>
        /// <returns>registerd user</returns>
        public UserRegistrationCL GetRegisterdUserByUserId(int UserId)
        {
            UserRegistrationCL user = new UserRegistrationCL();
            try
            {
                user = _context.proc_GetRegisteredUserByUserId(UserId)
                     .Select(p =>
                         new UserRegistrationCL
                         {
                             UserId = p.UserId,
                             FirstName = p.FirstName,
                             LastName = p.LastName,
                             Email = p.Email,
                             Password = p.Password,
                             MobileNumber = p.MobileNumber,
                             OrganizationName = p.OrganizationName,
                             AccountType = p.AccountType,
                             IsActive = p.IsActive,
                             RoleId = p.RoleId,
                             RoleName = p.RoleName
                         }).FirstOrDefault();

                return user;
            }
            catch (Exception ex)
            {
                return user;
            }
        }

        /// <summary>
        /// Delete registered user by UserId
        /// </summary>
        /// <param>userid</param>
        /// <returns>registerd user</returns>
        public bool EnableDisableRegisteredUser(int UserId, string isActive)
        {
            bool result = false;
            try
            {
                var userInfo = _context.tbl_UserGroup_Registration.Where(p => p.Super_User_Id == UserId).FirstOrDefault();
                if (userInfo != null)
                {
                    userInfo.Is_Login_Active = isActive;
                    _context.SaveChanges();
                    result = true;
                }
                else
                {
                    result = false;
                }
            }
            catch (Exception ex)
            {
                result = false;
            }
            return result;
        }

        /// <summary>
        /// Get all roles
        /// </summary>
        /// <param>userid</param>
        /// <returns>registerd user</returns>
        public List<DropDownCL> GetAllRoles()
        {
            List<DropDownCL> result = new List<DropDownCL>();
            try
            {
                result = _context.tbl_Roles.Where(p => p.Is_Deleted == "N").ToList().Select(p => new DropDownCL
                {
                    DataText = p.Role_Name + "",
                    DataValue = p.Role_ID + ""
                }).ToList();
            }
            catch (Exception ex)
            {
                var error = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// Add Update role user by RoleId
        /// </summary>
        /// <param>RoleId,RoleName</param>
        public bool AddUpdateRole(int RoleId, string RoleName)
        {
            try
            {
                _context.proc_AddUpdateRolesByRoleId(RoleId, RoleName);
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public bool IsRoleExist(string RoleName)
        {
            try
            {
                var result = _context.tbl_Roles.Where(s => s.Role_Name.ToLower() == RoleName.ToLower()).FirstOrDefault();
                if (result != null)
                    return true;
                else
                    return false;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        /// <summary>
        /// Delete role user by RoleId
        /// </summary>
        /// <param>Roleid</param>
        public bool DeleteRoleByRoleId(int RoleId)
        {
            try
            {
                var result = _context.tbl_Roles.Where(p => p.Role_ID == RoleId).FirstOrDefault();
                result.Is_Deleted = "Y";

                _context.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public List<MenuCL> GetMenuByRoleId(int RoleId)
        {
            List<MenuCL> result = new List<MenuCL>();
            try
            {
                result = _context.proc_GetMenuByRoleId(RoleId).ToList().Select(p => new MenuCL
                {
                    MenuID = p.Menu_ID,
                    MenuLevel = p.Menu_Level,
                    MenuLink = p.Menu_Link,
                    MenuName = p.Menu_Name,
                    MenuOrder = p.Menu_Order,
                    MenuStatus = p.Menu_Status,
                    ProjectName = p.Project_Name
                }).ToList();
            }
            catch (Exception ex)
            {
                var error = ex.Message;
            }
            return result;
        }

        public bool DeleteUserMenuByMenuId(int RoleId, int MenuId)
        {
            try
            {
                var result = _context.tbl_UserMenu.Where(p => p.Role_ID == RoleId && p.Menu_ID == MenuId).FirstOrDefault();
                result.Menu_Status = "N";

                _context.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public List<DropDownCL> GetAllMenu()
        {
            List<DropDownCL> result = new List<DropDownCL>();
            try
            {
                result = _context.tbl_Menu.Where(p => p.Is_Deleted == "N").ToList().Select(p => new DropDownCL
                {
                    DataText = p.Menu_Name + "",
                    DataValue = p.Menu_id + ""
                }).ToList();
            }
            catch (Exception ex)
            {
                var error = ex.Message;
            }
            return result;
        }

        public bool AddMenuToUserMenuByRoleId(int RoleId, int MenuId)
        {
            try
            {
                _context.proc_AddMenuToUserMenuByRoleId(RoleId, MenuId);
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public bool IsMenuAlreadyExistInUserMenu(int RoleId, int MenuId)
        {
            try
            {
                var result = _context.tbl_UserMenu.Where(s => s.Role_ID == RoleId && s.Menu_ID == MenuId).FirstOrDefault();
                if (result != null)
                    return true;
                else
                    return false;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public bool DeleteMenuByMenuId(int MenuId)
        {
            try
            {
                var result = _context.tbl_Menu.Where(p => p.Menu_id == MenuId).FirstOrDefault();
                result.Is_Deleted = "Y";

                _context.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public bool IsMenuExist(string MenuName)
        {
            try
            {
                var result = _context.tbl_Menu.Where(s => s.Menu_Name.ToLower() == MenuName.ToLower()).FirstOrDefault();
                if (result != null)
                    return true;
                else
                    return false;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public bool AddUpdateMenu(int MenuId, string MenuName)
        {
            try
            {
                _context.proc_AddUpdateMenu(MenuId, MenuName);
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public bool IsOldPasswordVaild(string emailId, string OldPassword)
        {
            try
            {
                var result = _context.tbl_UserGroup_Registration.Where(s => s.EmailID.ToLower() == emailId.ToLower().Trim()).FirstOrDefault();
                if (result != null)
                {
                    if (result.Password.Trim() == OldPassword.Trim())
                        return true;
                    else
                        return false;
                }
                else
                    return false;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public bool UpdateNewPassword(string emailId, string Password)
        {
            try
            {
                var result = _context.tbl_UserGroup_Registration.Where(s => s.EmailID.ToLower() == emailId.ToLower().Trim()).FirstOrDefault();
                if (result != null)
                {
                    result.Password = Password.Trim();
                    result.Confirm_Password = Password.Trim();
                    _context.SaveChanges();
                    return true;
                }
                else
                    return false;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}
