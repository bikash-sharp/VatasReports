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
            return
                _context.proc_GetUserRoleByRoleId(RoleId)
                    .Select(p => new DropDownCL { DataText = p.UserName, DataValue = p.UserID.ToString() })
                    .ToList();
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
                _context.proc_AddUpdateUser(user.UserId, user.FirstName, user.LastName, user.Email, user.Password, user.MobileNumber, user.AccountType, user.RoleId);
                return true;
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
        public List<UserRegistrationCL> GetAllRegisterdUsers()
        {
            List<UserRegistrationCL> users = new List<UserRegistrationCL>();
            try
            {
                users = _context.proc_GetAllRegisteredUsers().ToList()
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
        public bool DeleteRegisteredUser(int UserId)
        {
            try
            {
                var result = _context.tbl_UserGroup_Registration.Where(p => p.Super_User_Id == UserId).FirstOrDefault();
                result.Is_Login_Active = "N";

                _context.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
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
        /// Get all menus
        /// </summary>
        /// <param>userid</param>
        /// <returns>registerd user</returns>
        public bool GetAllMenus()
        {
            try
            {
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

    }
}
